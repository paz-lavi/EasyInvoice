//
//  Logger.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 18/07/2021.
//

import Foundation
class Logger : NSObject{
  static  let shared = Logger()
     private override init() {
        
    }
    
    public func logDebug(_ msg: String){
        NSLog("[Paz][Debug]: \(msg)")
    }
}
