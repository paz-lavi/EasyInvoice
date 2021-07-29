//
//  InvoceSettingsViewController.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 23/07/2021.
//

import UIKit

class InvoiceSettingsViewController: UIViewController {

    @IBOutlet weak var saveBTN: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var typeEDT: UITextField!
    @IBOutlet weak var titleEDT: UITextField!
    @IBOutlet weak var typeLBL: UILabel!
    @IBOutlet weak var titleLBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        // Do any additional setup after loading the view.
    }
    
    private func localize(){
        saveBTN.localizeLable()
        navBar.localize()
        typeEDT.localizeHint()
        titleEDT.localizeHint()
        typeLBL.localizeLable()
        titleLBL.localizeLable()

    }
    
    private func bindData(){
        if let b = BusinessManager.shared.business {
            typeEDT.text = b.documentType
            titleEDT.text = b.invoiceTitle
            
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        var changed = false
        guard let b = BusinessManager.shared.business  else {
            showAlertDialog("userIdNotFound".localize)
            return
        }
        if typeEDT.text != nil && typeEDT.text != b.documentType{
            BusinessManager.shared.business!.documentType = typeEDT.text!
            changed = true
        }
        if titleEDT.text != nil && titleEDT.text != b.invoiceTitle{
            BusinessManager.shared.business!.invoiceTitle = titleEDT.text!
            changed = true
        }
        if changed{
            BusinessManager.shared.updateUserInDB()
            showAlertDialog("savingBusiness".localize)

        }
    }
    
  
  
    
}
