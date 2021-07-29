//
//  SignUpViewController.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 17/07/2021.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signUpLBL: UILabel!
    @IBOutlet weak var fillDetailsLBL: UILabel!
    @IBOutlet weak var businessNameEDT: UITextField!
    
    @IBOutlet weak var lastInvoceNumberEDT: UITextField!
    @IBOutlet weak var signUpBTN: UIButton!
    @IBOutlet weak var businessAddressEDT: UITextField!
    @IBOutlet weak var businessTypeEDT: UITextField!
    @IBOutlet weak var businessPhoneEDT: UITextField!
    @IBOutlet weak var businessNumberEDT: UITextField!
    var isExpand = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpBTN.localizeTitle()
        signUpLBL.localizeLable()
        fillDetailsLBL.localizeLable()
        businessNameEDT.localizeHint()
        businessAddressEDT.localizeHint()
        businessTypeEDT.localizeHint()
        businessPhoneEDT.localizeHint()
        businessNumberEDT.localizeHint()
        lastInvoceNumberEDT.localizeHint()
        scrollView.isScrollEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDatabaseResults), name: .onDatabaseResults, object: nil)

        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        if let uid = Auth.auth().currentUser?.uid {
            DB.shared.getBusinessFromDatabase(uid: uid)
        }
    }
    
    @IBAction func onSignUpClicked(_ sender: Any) {
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
        guard let uid = Auth.auth().currentUser?.uid  else {
            showAlertDialog("userIdNotFound".localize)
            return
        }
        
        let business = BusinessModel(businessName: name, businessNumber: number, businessPhone: phone, businessType: type, businessAddress:  address, lastInvoceNumber: lastInvoice, businessUID: uid)
        
        DB.shared.addBusinessToDatabase(business)
        showSucssesDialog("savingBusiness".localize)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            BusinessManager.shared.loadBusiness()
        }

    }
    
}

// MARK: Notifications handlers
extension SignUpViewController{
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
    
    @objc func onDatabaseResults(_ notification: Notification){
        if let data = notification.userInfo! as? [String: Bool] {
             let res = data["found"]
            if res == true {
                navigateToHomePage()

            }else{
                showAlertDialog("failedToLoadBusiness".localize)

            }
        }
        
    }
    
}

// MARK: My logic
extension SignUpViewController{
    

    
    private func navigateToHomePage(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "myTab") as! UITabBarController
        nextViewController.modalPresentationStyle = .fullScreen
        nextViewController.modalTransitionStyle = .crossDissolve
        self.navigationController?.showDetailViewController(nextViewController, sender: nil)
    }
}
