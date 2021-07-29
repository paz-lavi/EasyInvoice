//
//  InvoiceModel.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 29/07/2021.
//

import Foundation
class InvoiceModel:  Codable, Comparable {
    static func == (lhs: InvoiceModel, rhs: InvoiceModel) -> Bool {
       return lhs.invoiceURL == rhs.invoiceURL &&
        lhs.date == rhs.date &&
        lhs.timestamp == rhs.timestamp &&
        lhs.invoiceNumber == rhs.invoiceNumber &&
        lhs.totalPrice == rhs.totalPrice &&
        lhs.client == rhs.client &&
        lhs.items == rhs.items
    }
    
    static func < (lhs: InvoiceModel, rhs: InvoiceModel) -> Bool {
    return    (lhs.invoiceNumber - rhs.invoiceNumber) > 0
    }
    
    var invoiceURL : String
    var date: String
    var timestamp : Double
    var invoiceNumber : Int
    var totalPrice : Double
    var client : ClientModel?
    var items : [InvoiceItem]?
    
     init(  invoiceURL : String,
     date: String,
     timestamp : Double,
     invoiceNumber : Int,
     totalPrice : Double,
     client : ClientModel?,
     items : [InvoiceItem]?) {
        self.invoiceURL = invoiceURL
        self.date = date
        self.timestamp = timestamp
        self.invoiceNumber = invoiceNumber
        self.totalPrice = totalPrice
        self.client = client
        self.items = items
    }
    
     init() {
        self.invoiceURL = ""
        self.date = ""
        self.timestamp = -1
        self.invoiceNumber = -1
        self.totalPrice = -1
        self.client = nil
        self.items = nil
    }
}
