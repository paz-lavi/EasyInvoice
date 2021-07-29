//
//  TextFiledExt.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 17/07/2021.
//

import Foundation
import  UIKit
extension UITextField{
    
    func  localizeLable(){
        self.text = self.text?.localize
    }
    func  localizeHint(){
        self.placeholder = self.placeholder?.localize
    }
    
}
