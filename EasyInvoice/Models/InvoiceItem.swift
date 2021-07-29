//
//  invoiceItem.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 25/07/2021.
//

import Foundation
class InvoiceItem: NSObject , Codable{
    var itemDescription :String
    var unitCost: Double
    var quantity : Int
    var discountType : String
    var discountAnount : Double
    var totalWithoutTax: Double
    var totalWithTax: Double
    var taxRate : Double
    
     init(  itemDescription :String,
     unitCost: Double,
     quantity : Int,
     discountType : String,
     discountAnount : Double,
     totalWithoutTax: Double,
     totalWithTax: Double,
     taxRate : Double) {
        
        self.itemDescription = itemDescription
        self.unitCost = unitCost
        self.quantity = quantity
        self.discountType = discountType
        self.discountAnount = discountAnount
        self.totalWithoutTax = totalWithoutTax
        self.totalWithTax = totalWithTax
        self.taxRate = taxRate

    }
    
    convenience override init() {
        self.init(itemDescription: "",unitCost: 0.0,quantity: 0,discountType: "",discountAnount: 0.0,totalWithoutTax: 0.0,totalWithTax: 0.0,taxRate: 0.0)
    }
    
}
