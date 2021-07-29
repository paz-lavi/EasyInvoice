//
//  BusinessManager.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 18/07/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
class BusinessManager: NSObject {
  static  let shared = BusinessManager()
    var business : BusinessModel? = nil
    
    private override init() {
        super.init()
        DB.shared.delegate = self
      
    }
    
    public func loadBusiness(){
        if   let uid = Auth.auth().currentUser?.uid{
            DB.shared.getBusinessFromDatabase(uid: uid)
        }
    }
    
    public func updateUserInDB(){
        if business != nil{
        DB.shared.updateUserInDB(business!)
        }
        
    }
}
extension BusinessManager : DBDelegate{
    func onBusinessNotFound() {

    }
    
    func onBusinessReady(_ business: BusinessModel) {
        self.business = business
        Logger.shared.logDebug("BusinessManager - got business \(business.description)")
    }
    
    
}
