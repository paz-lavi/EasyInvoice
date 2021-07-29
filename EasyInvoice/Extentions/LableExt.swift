//
//  LableExt.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 17/07/2021.
//

import Foundation
import UIKit
extension UILabel{
    func  localizeLable(){
        self.text = self.text?.localize
    }
     

}

extension UINavigationItem{
    func  localize(){
        self.title = self.title?.localize
    }
}
