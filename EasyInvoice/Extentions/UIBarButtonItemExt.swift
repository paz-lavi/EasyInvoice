//
//  ViewExt.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 18/07/2021.
//

import Foundation
import UIKit
extension UIBarButtonItem{
    func  localizeLable(){
        self.title = self.title?.localize
    }
}
