//
//  EncodableExt.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 18/07/2021.
//

import Foundation
extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
    var  json : String?{
        guard let jsonData = try? JSONEncoder().encode(self) else { return nil }
        return String(data: jsonData, encoding: .utf8)!
    }
    
}



extension Dictionary {
    var jsonStringRepresentaiton: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: []) else {
            return nil
        }

        return String(data: theJSONData, encoding: .utf8)
    }
}
