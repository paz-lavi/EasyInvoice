//
//  BuisnnesModel.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 17/07/2021.
//
import Foundation
class BusinessModel: NSObject, Codable {
    var businessName : String = ""
    var businessNumber : String = ""
    var businessPhone : String = ""
    var businessType : String = ""
    var businessAddress : String = ""
    var lastInvoceNumber: Int = 0
    var businessUID : String = "" // firebase user ID
    var invoiceTitle : String = ""
    var documentType : String = ""
    var taxLabel : String = ""
    var taxRate : Double = 0.0
    var shouldIncludeTax : Bool = false
    var inclusive : Bool = false
    var logoURI : String = ""
    public override var description: String { return self.json ?? "nil" }

//    enum CodingKeys: String, CodingKey {
//         case businessName
//         case businessNumber
//         case businessPhone
//         case businessType
//         case businessAddress
//        case lastInvoceNumber
//        case businessUID
//
//     }
    override  init() {
    }
    
    init(dic : [String:Any]) {
    super.init()
        self.businessName = dic["businessName"] as! String? ?? ""
        self.businessNumber = dic["businessNumber"] as! String? ?? ""
        self.businessPhone = dic["businessPhone"] as! String? ?? ""
        self.businessType = dic["businessType"] as! String? ?? ""
        self.businessAddress = dic["businessAddress"] as! String? ?? ""
        self.lastInvoceNumber = dic["lastInvoceNumber"] as! Int? ?? 0
        self.businessUID = dic["businessUID"] as! String? ?? ""
        self.invoiceTitle = dic["invoiceTitle"] as! String? ?? ""
        self.documentType = dic["documentType"] as! String? ?? ""
        self.taxLabel = dic["taxLabel"] as! String? ?? ""
        self.taxRate = dic["taxRate"] as! Double? ?? 0.0
        self.shouldIncludeTax = dic["shouldIncludeTax"] as! Bool? ?? false
        self.inclusive = dic["inclusive"] as! Bool? ?? false
        self.logoURI = dic["logoURI"] as! String? ?? ""

    }
   
      init(  businessName : String,
     businessNumber : String,
     businessPhone : String,
     businessType : String,
     businessAddress : String,
     lastInvoceNumber: Int,
     businessUID : String ) {
        self.businessName = businessName
        self.businessNumber = businessNumber
        self.businessPhone = businessPhone
        self.businessType = businessType
        self.businessAddress = businessAddress
        self.lastInvoceNumber = lastInvoceNumber
        self.businessUID = businessUID

    }
    
    static func decode(json: String) -> BusinessModel? {
     let jsonDecoder = JSONDecoder()
        do{
             let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            return try jsonDecoder.decode(BusinessModel.self, from: jsonData)}
        catch {
            print(error.localizedDescription)
            return nil
        }
        
         }
   
}
