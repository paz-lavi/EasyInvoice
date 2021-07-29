//
//  AddItemViewController.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 25/07/2021.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var totalAmountLBL: PaddingLabel!
    @IBOutlet weak var totalLBL: PaddingLabel!
    @IBOutlet weak var discountAmountEDT: UITextField!
    @IBOutlet weak var discountAmountLBL: UILabel!
    @IBOutlet weak var percentageBTN: UIButton!
    @IBOutlet weak var flatAbountBTN: UIButton!
    @IBOutlet weak var discountLBL: UILabel!
    @IBOutlet weak var quantityEDT: UITextField!
    @IBOutlet weak var quantityLBL: UILabel!
    @IBOutlet weak var unitCostEDT: UITextField!
    @IBOutlet weak var unitCostLBL: UILabel!
    @IBOutlet weak var descriptionEDT: UITextField!
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var addBTN: UIButton!
    var lastClickedBTN: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        lastClickedBTN = percentageBTN

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    

    @IBAction func onDiscountTypeSelected(_ sender: UIButton) {
        if sender == percentageBTN{
            lastClickedBTN = percentageBTN
            percentageBTN.borderColor = UIColor.green
            flatAbountBTN.borderColor = UIColor.systemBackground
        }else if sender == flatAbountBTN{
            lastClickedBTN = flatAbountBTN
            flatAbountBTN.borderColor = UIColor.green
            percentageBTN.borderColor = UIColor.systemBackground
        }
    }
    
    @IBAction func addItemClicked(_ sender: Any) {
        guard let des = descriptionEDT.text  else {
            showAlertDialog("missingDescription".localize)
            return
        }
        
        guard var unitCost = (unitCostEDT.text as NSString?)?.doubleValue else {
            showAlertDialog("missingUnitCost".localize)
            return
        }
        guard let quantity = (quantityEDT.text as NSString?)?.integerValue else {
            showAlertDialog("missingQuantity".localize)
            return
        }
        
        let discountAmount = (discountAmountEDT.text as NSString?)?.doubleValue
        
        let discountType = lastClickedBTN == percentageBTN ? "percentage".localize : "flatAbount".localize
        
        if des.isEmpty{
            showAlertDialog("missingDescription".localize)
            return
        }
      
        if quantity == 0{
            showAlertDialog("missingQuantity".localize)
            return
        }
        
        let b = BusinessManager.shared.business!
        
        if discountAmount != nil && discountAmount! > 0{
            if discountType == "percentage".localize{
                unitCost =  unitCost / Double((1 + discountAmount! / 100))
            }else{
                unitCost =  unitCost - Double(discountAmount! / Double(quantity))

            }
        }
          
        var priceWithTax : Double!
        var priceWithoutTax : Double!

        if b.shouldIncludeTax{
            if b.inclusive{
                priceWithTax = unitCost
                priceWithoutTax = unitCost / Double((1 + b.taxRate / 100))
            }else{
                priceWithoutTax = unitCost
                priceWithTax = unitCost * (1 + b.taxRate / 100)
            }
        }else{
            priceWithTax = unitCost
            priceWithoutTax = unitCost
        }
        
      
        
        let item = InvoiceItem(itemDescription: des, unitCost: unitCost, quantity: quantity, discountType: discountType, discountAnount: discountAmount ?? 0, totalWithoutTax: priceWithoutTax * Double(quantity), totalWithTax: priceWithTax * Double(quantity), taxRate: b.taxRate)
        NotificationCenter.default.post(name: .newItemReady, object: nil, userInfo: ["item": item])
        descriptionEDT.text = ""
        quantityEDT.text = "1"
        unitCostEDT.text = ""
        discountAmountEDT.text  = "0"
        totalAmountLBL.text = ""
        showSucssesDialog("itemAddedSucssesfully".localize)
        

    }
}

// MARK: Notifications handlers
extension AddItemViewController{

    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

    
}

