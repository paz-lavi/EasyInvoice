//
//  ButtonExt.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 17/07/2021.
//

import Foundation
import UIKit
extension UIButton{
    func  localizeTitle(){
        let title = self.titleLabel?.text?.localize
        self.setTitle(title, for: .normal)
    }
    
}
