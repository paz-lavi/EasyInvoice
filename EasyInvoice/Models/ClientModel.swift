//
//  ClientModel.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 26/07/2021.
//

import Foundation
class ClientModel: NSObject , Codable {
    let uName : String
    let uAddress : String?
    let uPhone : String?
    let uEmail : String?
    
     init(   uName : String,
     uAddress : String?,
     uPhone : String?,
     uEmail : String?) {
        self.uName = uName
        self.uAddress = uAddress
        self.uEmail = uEmail
        self.uPhone = uPhone
    }
}
