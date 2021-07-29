//
//  StringExt.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 17/07/2021.
//

import Foundation
extension String{
    var localize: String{
        NSLog("Localizing \(self)")
        let res = NSLocalizedString(self, comment: "")
        NSLog("Localizing res: \(res)")

        return res
    }
}
extension Double {
 
    var stringValue: String {
     
        return String(format: "%.1f", self)
    }
}
extension Int {
 
    var stringValue: String {
     
        return String(format: "%d", self)
    }
}
