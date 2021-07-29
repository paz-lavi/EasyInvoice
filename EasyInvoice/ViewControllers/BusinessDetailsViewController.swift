//
//  BusinessDetailsViewController.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 19/07/2021.
//

import Foundation
import UIKit
import MobileCoreServices


class BusinessDetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var logoLBL: UILabel!
    @IBOutlet weak var saveBTN: UIBarButtonItem!
    
    @IBOutlet weak var selectLogoBTN: UIButton!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var logoIMG: UIImageView!
    @IBOutlet weak var lastInvoceNumberEDT: UITextField!
    @IBOutlet weak var lastInvoceNumberLBL: UILabel!
    @IBOutlet weak var businessAddressEDT: UITextField!
    @IBOutlet weak var businessAddressLBL: UILabel!
    @IBOutlet weak var businessPhoneEDT: UITextField!
    @IBOutlet weak var businessPhoneLBL: UILabel!
    @IBOutlet weak var businessTypeEDT: UITextField!
    @IBOutlet weak var businessTypeLBL: UILabel!
    @IBOutlet weak var businessNumberEDT: UITextField!
    @IBOutlet weak var businessNumberLBL: UILabel!
    @IBOutlet weak var businessNameEDT: UITextField!
    @IBOutlet weak var businessNameLBL: UILabel!
    var isExpand = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled = true
        navBar.localize()
        logoLBL.localizeLable()
        selectLogoBTN.localizeTitle()
        lastInvoceNumberLBL.localizeLable()
        businessAddressLBL.localizeLable()
        businessTypeLBL.localizeLable()
        businessNumberLBL.localizeLable()
        businessNameLBL.localizeLable()
        businessPhoneLBL.localizeLable()
        lastInvoceNumberEDT.localizeHint()
        businessAddressEDT.localizeHint()
        businessPhoneEDT.localizeHint()
        businessTypeEDT.localizeHint()
        businessNumberEDT.localizeHint()
        businessNameEDT.localizeHint()
        saveBTN.localizeLable()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        
        if let b = BusinessManager.shared.business {
            lastInvoceNumberEDT.text = String(b.lastInvoceNumber)
            businessAddressEDT.text = b.businessAddress
            businessTypeEDT.text = b.businessType
            businessNumberEDT.text = b.businessNumber
            businessNameEDT.text = b.businessName
            businessPhoneEDT.text = b.businessPhone
         
            if !b.logoURI.isEmpty{
                logoIMG.setNetworkImage(from: b.logoURI)
            }
        }
    }
    
    @IBAction func selectLogoButtonClicked(_ sender: Any) {
        let imageMediaType = kUTTypeImage as String
        
        // Define and present the `UIImagePickerController`
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary
        pickerController.mediaTypes = [imageMediaType]
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        guard let name = businessNameEDT.text , !name.isEmpty else {
            showAlertDialog("missingBusinessName".localize)
            return
        }
        guard let number = businessNumberEDT.text , !number.isEmpty else {
            showAlertDialog("missingBusinessNumber".localize)
            return
        }
        guard let phone = businessPhoneEDT.text , !phone.isEmpty else {
            showAlertDialog("missingBusinessPhone".localize)
            return
        }
        guard let type = businessTypeEDT.text, !type.isEmpty  else {
            showAlertDialog("missingBusinessType".localize)
            return
        }
        guard let address = businessAddressEDT.text , !address.isEmpty else {
            showAlertDialog("missingBusinessAddress".localize)
            return
        }
        guard let lastInvoiceTxt = lastInvoceNumberEDT.text, !lastInvoiceTxt.isEmpty  else {
            showAlertDialog("missingLastInvoceNumber".localize)
            return
        }
        guard let lastInvoice = Int(lastInvoiceTxt) else {
            showAlertDialog("missingLastInvoceNumber".localize)
            return
        }
        if BusinessManager.shared.business == nil {
            showAlertDialog("userIdNotFound".localize)
            return
        }
        BusinessManager.shared.business!.businessName = name
        BusinessManager.shared.business!.businessNumber = number
        BusinessManager.shared.business!.businessPhone = phone
        BusinessManager.shared.business!.businessType = type
        BusinessManager.shared.business!.businessAddress = address
        BusinessManager.shared.business!.lastInvoceNumber =  lastInvoice
        BusinessManager.shared.updateUserInDB()
        showAlertDialog("savingBusiness".localize)
        
        
    }
}


// MARK: Notifications handlers
extension BusinessDetailsViewController{
    @objc func keyboardApear(_ notification: Notification){
        NSLog("keyboardApear")
        if !isExpand{
            var delta = CGFloat(300)
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                delta = keyboardRectangle.height
            }
            self.scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height + delta)
        }
        isExpand = true
    }
    @objc func keyboardDisapear(_ notification: Notification){
        NSLog("keyboardDisapear")
        
        if isExpand{
            var delta = CGFloat(300)
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                delta = keyboardRectangle.height
            }
            self.scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height - delta)
        }
        isExpand = false
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}


// MARK: My Logic
extension BusinessDetailsViewController{
  
}

extension BusinessDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Check for the media type
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! CFString
        if mediaType == kUTTypeImage {
            let imageURL = info[UIImagePickerController.InfoKey.imageURL] as! URL
            DB.shared.uploadLogoToStorage(fileUrl: imageURL, business: BusinessManager.shared.business!)
            
        }
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            logoIMG.contentMode = .scaleAspectFit
            logoIMG.image = img
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
