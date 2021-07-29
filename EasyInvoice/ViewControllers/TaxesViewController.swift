//
//  TaxesViewController.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 23/07/2021.
//

import UIKit

class TaxesViewController: UIViewController {

    @IBOutlet weak var inclusiveMsgLBL: UILabel!
    @IBOutlet weak var inclusiveSWITCH: UISwitch!
    @IBOutlet weak var inclusiveLBL: UILabel!
    @IBOutlet weak var taxlLableEDT: UITextField!
    @IBOutlet weak var taxLableLBL: UILabel!
    @IBOutlet weak var rateEDT: UITextField!
    @IBOutlet weak var rateLBL: UILabel!
    @IBOutlet weak var includeSWITCH: UISwitch!
    @IBOutlet weak var incluseLBL: UILabel!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var saveBTN: UIBarButtonItem!
    @IBOutlet weak var card: CardView!
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        bindData()
    }

    @IBAction func saveButtonClicked(_ sender: Any) {
        var changed = false
        guard let b = BusinessManager.shared.business  else {
            showAlertDialog("userIdNotFound".localize)
            return
        }
        let include = includeSWITCH.isOn
        let rate = (rateEDT.text as NSString?)?.doubleValue
        let lable = taxlLableEDT.text
        let inclusive = inclusiveSWITCH.isOn
        
        if include != b.shouldIncludeTax{
            BusinessManager.shared.business!.shouldIncludeTax = include
            changed = true
        }
        if lable != b.taxLabel && lable != nil{
            BusinessManager.shared.business!.taxLabel = lable!
            changed = true
        }
        if rate != b.taxRate && rate != nil{
            BusinessManager.shared.business!.taxRate = rate!
            changed = true
        }
        if inclusive != b.inclusive{
            BusinessManager.shared.business!.inclusive = inclusive
            changed = true
        }
        
        if changed{
            BusinessManager.shared.updateUserInDB()
            showAlertDialog("savingBusiness".localize)

        }
        
    }
    
    private func localize(){
        inclusiveMsgLBL.localizeLable()
        inclusiveLBL.localizeLable()
        taxlLableEDT.localizeHint()
        taxlLableEDT.localizeHint()
        taxLableLBL.localizeLable()
        rateEDT.localizeHint()
        rateLBL.localizeLable()
        incluseLBL.localizeLable()
        navBar.localize()
        saveBTN.localizeLable()
    }
    
    private func bindData(){
        if let b = BusinessManager.shared.business {
            includeSWITCH.isOn = b.shouldIncludeTax
            inclusiveSWITCH.isOn = b.inclusive
            rateEDT.text = String(b.taxRate)
            taxlLableEDT.text = b.taxLabel
        
            
        }
    }
    

    
}


