//
//  NotificationExt.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 20/07/2021.
//

import Foundation
extension Notification.Name {
    static let onDatabaseResults = Notification.Name("onDatabaseResults")
    static let uploadTaskDidComplete = Notification.Name("uploadTaskDidComplete")
    static let newItemReady = Notification.Name("newItemReady")
    static let clientInfoReady = Notification.Name("clientInfoReady")
    static let recivedInvoices = Notification.Name("recivedInvoices")




    
}
