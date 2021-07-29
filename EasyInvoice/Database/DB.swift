//
//  DB.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 18/07/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol DBDelegate {
    func onBusinessReady(_ business : BusinessModel);
    func onBusinessNotFound()
}

class DB: NSObject {
    static let shared  = DB()
    let db  = Firestore.firestore()
    var delegate: DBDelegate? = nil
    private override init() {
        
    }
    
    public func addBusinessToDatabase(_ business: BusinessModel){
        guard let dic = business.dictionary  else {
            return
        }
        db.collection("users").document(business.businessUID).setData(dic )
        
    }
    public func updateUserInDB(_ business: BusinessModel){
        guard let dic = business.dictionary  else {
            return
        }
        db.collection("users").document(business.businessUID).updateData(dic )
        
        
    }
    
    public func getBusinessFromDatabase(uid : String) {
        db.collection("users").document(uid).getDocument { (document, error) in
            var foundDic : [String : Bool] = ["found" : false]
            if let document = document, document.exists {
                if document.data() != nil{
                    let b =   BusinessModel(dic: document.data()! )
                    Logger.shared.logDebug(b.description)
                    foundDic["found" ] = true
                    self.delegate?.onBusinessReady(b)
                }
            } else {
                print("Document does not exist")
                
            }
            NotificationCenter.default.post(name: .onDatabaseResults, object: self, userInfo: foundDic)
            
        }
        
    }
    public func getAllInvoces() {
        guard let b =  BusinessManager.shared.business else {
            return
        }
        db.collection("users").document(b.businessUID).collection("invoices")
            .addSnapshotListener { documentSnapshot, error in
                guard documentSnapshot != nil else {
                print("Error fetching document: \(error!)")
                return
              }
                var invoices : [InvoiceModel] = []
                let decoder = JSONDecoder()
                for d in documentSnapshot!.documents{
                    do{
                        if let js = d.data().jsonStringRepresentaiton?.data(using: .utf8){
                        let i = try decoder.decode(InvoiceModel.self, from: js )
                            invoices.append(i)}
                    }catch{
                        Logger.shared.logDebug(error.localizedDescription)
                    }
                }
                invoices.sort()
                NotificationCenter.default.post(name: .recivedInvoices, object: self, userInfo: ["invoices": invoices])

            }
            
        }
        
    
    
    public func uploadInvoiceToStorage(invoice : InvoiceModel) {
        
        guard let b =  BusinessManager.shared.business, let json = invoice.dictionary else {
            return
        }
            db.collection("users").document(b.businessUID).collection("invoices").document(String(invoice.invoiceNumber)).setData(json)
           
    }
    
    
    
    func uploadLogoToStorage(fileUrl: URL, business : BusinessModel) {
        let fileExtension = fileUrl.pathExtension
        let fileName = "logo.\(fileExtension)"
      let metaData = StorageMetadata()
        let ref =  Storage.storage().reference().child(business.businessUID).child("logo").child(fileName)
        
        ref.putFile(from: fileUrl, metadata: metaData) { (storageMetaData, error) in
            var userInfo: [AnyHashable: Any] = [:]
            if storageMetaData != nil{
                userInfo["storageMetaData"]  = storageMetaData
            }
            if error != nil{
                userInfo["error"] = error
            }else{
                ref.downloadURL { (url, error) in
                      if let error = error  {
                        Logger.shared.logDebug("Error on getting download url: \(error.localizedDescription)")
                        return
                      }
                    Logger.shared.logDebug("Download url of \(fileName) is \(url!.absoluteString)")
                    BusinessManager.shared.business?.logoURI = url!.absoluteString
                    BusinessManager.shared.updateUserInDB()
                    }
                  
                
            }
            NotificationCenter.default.post(name: .uploadTaskDidComplete, object: nil, userInfo: userInfo)
      }
    }
    
    func uploadInvoiceToStorage(fileUrl: String, invoiceNumber : Int ,onComplite: @escaping (_ URL: String) -> Void) {
        guard let b =  BusinessManager.shared.business else {
            return
        }
      let metaData = StorageMetadata()
        let ref =  Storage.storage().reference().child(b.businessUID).child("invoces").child("invoice #\(invoiceNumber)")
        let localFile = URL(fileURLWithPath: fileUrl)


        ref.putFile(from: localFile, metadata: metaData) { (storageMetaData, error) in
            var userInfo: [AnyHashable: Any] = [:]
            if storageMetaData != nil{
                userInfo["storageMetaData"]  = storageMetaData
            }
            if error != nil{
                userInfo["error"] = error
            }else{
                ref.downloadURL { (url, error) in
                      if let error = error  {
                        Logger.shared.logDebug("Error on getting download url: \(error.localizedDescription)")
                        return
                      }
                    Logger.shared.logDebug("Download url of \(fileUrl) is \(url!.absoluteString)")
                    BusinessManager.shared.business?.logoURI = url!.absoluteString
                    onComplite(url!.absoluteString)
                    }
                  
                
            }
            NotificationCenter.default.post(name: .uploadTaskDidComplete, object: nil, userInfo: userInfo)
      }
    }
}
