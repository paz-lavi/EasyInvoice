//
//  NewInvoiceViewController.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 24/07/2021.
//

import UIKit
import SignaturePad


class NewInvoiceViewController: UIViewController {
    
    @IBOutlet weak var createBTN: UIBarButtonItem!
    @IBOutlet weak var totalLBL: UILabel!
    @IBOutlet weak var discountLBL: UILabel!
    @IBOutlet weak var taxLBL: UILabel!
    @IBOutlet weak var itemsCountLBL: UILabel!
    @IBOutlet weak var itemsTable: UITableView!
    @IBOutlet weak var addItemBTN: UIButton!
    @IBOutlet weak var clientInfoBTN: UIButton!
    @IBOutlet weak var navBar: UINavigationItem!
    private var items : [InvoiceItem] = []
    private var clientModel : ClientModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.localize()
        NotificationCenter.default.addObserver(self, selector: #selector(onNewItemRecived), name: .newItemReady, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onClientRecived), name: .clientInfoReady, object: nil)
        
        itemsTable.dataSource = self
        itemsTable.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "createToSignature"{
            if items.count == 0   {
                showAlertDialog("missingInvoiceItems".localize)
                return false
            }
            if clientModel == nil  {
                showAlertDialog("missingClientInfo".localize)
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
        if segue.destination is SignatureViewController{
            (segue.destination as! SignatureViewController).items = items
            (segue.destination as! SignatureViewController).clientModel = clientModel
        }
    }
}

extension NewInvoiceViewController{
    private func updateCurrentInvoiceState(){
        var total = 0.0
        var dis = 0.0
        var tax = 0.0
        for i in items{
            total += i.totalWithTax
            tax += i.totalWithTax - i.totalWithoutTax
            dis += i.discountAnount
        }
        self.itemsCountLBL.text = String(items.count)
        self.taxLBL.text = tax.stringValue
        self.discountLBL.text = dis.stringValue
        self.totalLBL.text = total.stringValue
    }
}

extension NewInvoiceViewController{
    @objc   private func onNewItemRecived(_ notification : Notification){
        if let data = (notification.userInfo!  as? [String: InvoiceItem]){
            let item = data["item"]
            if item != nil{
                items.append(item!)
                itemsTable.reloadData()
                updateCurrentInvoiceState()
            }
            Logger.shared.logDebug(item?.dictionary?.jsonStringRepresentaiton ?? "nil")
            
        }
    }
    
    @objc   private func onClientRecived(_ notification : Notification){
        if let data = (notification.userInfo!  as? [String: ClientModel]){
            let client = data["client"]
            if client != nil{
                clientModel = client
            }
            Logger.shared.logDebug(client?.dictionary?.jsonStringRepresentaiton ?? "nil")
            
        }
    }
}

// MARK: Table View (items)
extension NewInvoiceViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceItemTableViewCell", for: indexPath) as! InvoiceItemTableViewCell
        let item =  items[indexPath.item]
        cell.descriptionLBL.text = item.itemDescription
        cell.discountAmountLBL.text = "Discount amount:\(item.discountAnount.stringValue)"
        cell.discountLBL.text = "Discount type: \(item.discountType)"
        cell.quantityLBL.text = "Quantity: \(item.quantity.stringValue)"
        cell.unitCostLBL.text = "Cost per unit\(item.unitCost.stringValue)"
        cell.totalLBL.text = "Total cost: \(item.totalWithTax.stringValue)"
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell =  tableView.cellForRow(at: indexPath) as! InvoiceItemTableViewCell
        Logger.shared.logDebug(cell.descriptionLBL?.text ?? "nil")
        
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            itemsTable.deleteRows(at: [indexPath], with: .fade)
        } 
    }
    
    
}
