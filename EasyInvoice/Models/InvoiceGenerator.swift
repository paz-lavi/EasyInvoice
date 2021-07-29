//
//  InvoiceGenerator.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 26/07/2021.
//

import Foundation
import UIKit
import PDFGenerator
protocol InvoiceGeneratorDelegate {
    func onInvoiceReady(_ url : String)
    func onError(_ error : Error?)
}

class InvoiceGenerator: NSObject {
    var items : [InvoiceItem]
    var clientModel : ClientModel
    var signature : UIImage
    var delegate : InvoiceGeneratorDelegate? = nil
    
    init(  items : [InvoiceItem],
           clientModel : ClientModel,
           signature : UIImage) {
        self.items = items
        self.clientModel = clientModel
        self.signature = signature
    }
    
    func generateInvoice(){
        
        let b = BusinessManager.shared.business!
        let invoice = UIInvoice(frame: CGRect(x: 0, y: 0, width: 595.2, height: 841.8))
        invoice.logoIMG.setNetworkImage(from: b.logoURI)
        invoice.signatureIMG.image = signature
        invoice.businessAddressLBL.text = b.businessAddress
        invoice.businessNameLBL.text = b.businessName
        invoice.invoiceLBL.text = b.invoiceTitle
        invoice.businessNumberLBL.text = b.businessNumber
        invoice.businessPhoneLBL.text = b.businessPhone
        invoice.typeLBL.text = b.businessType
        invoice.businessAddressLBL.text = "#\(b.lastInvoceNumber)"
        invoice.originalLBL.text = "original".localize
        invoice.cNameLBL.text = clientModel.uName
        invoice.cEmailLBL.text = clientModel.uEmail
        invoice.cAddressLBL.text = clientModel.uAddress
        invoice.cPhoneLBL.text = clientModel.uPhone
        invoice.dateLBL.text = Date().today()
        invoice.setItems(items: items)
        let page: [PDFPage] = [PDFPage.view(invoice) ]
        // wait for laading logo
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            do {
                let path = NSTemporaryDirectory().appending("sample1.pdf")
                try PDFGenerator.generate(page, to: path, password: "")
                
                DB.shared.uploadInvoiceToStorage(fileUrl: path,invoiceNumber: b.lastInvoceNumber + 1, onComplite: {url in
                    BusinessManager.shared.business!.lastInvoceNumber +=  1

                    let i = InvoiceModel(invoiceURL: url, date: Date().today(), timestamp: Date().timeIntervalSince1970, invoiceNumber: BusinessManager.shared.business!.lastInvoceNumber , totalPrice: invoice.getPriceWithTax(), client: self.clientModel, items: self.items)
                    BusinessManager.shared.updateUserInDB()
                    DB.shared.uploadInvoiceToStorage(invoice: i)
                    self.delegate?.onInvoiceReady(url )
                })
            } catch let error {
                print(error)
                self.delegate?.onError(error)
            }
        }
        
        
        
    }
}
