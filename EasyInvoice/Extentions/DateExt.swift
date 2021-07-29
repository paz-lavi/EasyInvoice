//
//  Date.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 27/07/2021.
//

import Foundation

extension Date{
     func today() -> String{
     
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        return formatter1.string(from: self)
    }
}
