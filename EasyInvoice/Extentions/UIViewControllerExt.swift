//
//  UIViewControllerExt.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 26/07/2021.
//

import Foundation
import UIKit
extension UIViewController{
     func showAlertDialog(_ msg :String){
        let alert = UIAlertController(title: "errorTitle".localize, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "close".localize, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showSucssesDialog(_ msg :String){
       let alert = UIAlertController(title: "sucsses".localize, message: msg, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "close".localize, style: .default, handler: nil))
       self.present(alert, animated: true)
   }
    
    func  shareLink(url : String){
        let activityViewController = UIActivityViewController(activityItems: [NSURL(string:url)!], applicationActivities: nil)


        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
        UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
//        // Anything you want to exclude
//        activityViewController.excludedActivityTypes = [
//            UIActivity.ActivityType.postToWeibo,
//            UIActivity.ActivityType.print,
//            UIActivity.ActivityType.assignToContact,
//            UIActivity.ActivityType.saveToCameraRoll,
//            UIActivity.ActivityType.addToReadingList,
//            UIActivity.ActivityType.postToFlickr,
//            UIActivity.ActivityType.postToVimeo,
//            UIActivity.ActivityType.postToTencentWeibo,
//            UIActivity.ActivityType.postToFacebook
//        ]
//
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
}

 
