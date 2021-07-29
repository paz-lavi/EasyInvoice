//
//  HomeViewController.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 17/07/2021.
//

import UIKit

class InvoicesViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var newInvoiceBTN: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    
    var items : [InvoiceModel]?
    override func viewDidLoad() {
        DB.shared.getAllInvoces()
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(recivedInvoices), name: .recivedInvoices, object: nil)
        tableView.dataSource = self
        tableView.delegate = self
        localize()
        // Do any additional setup after loading the view.
    }
    private func localize(){
        navBar.localize()
        newInvoiceBTN.localizeLable()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let s = sender as? InvoiceTableViewCell{
        if segue.identifier == "PDFViewController"{
            if let nextViewController = segue.destination as? PDFViewController {
                nextViewController.invoice = s.invoice
            }
        }}
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @objc private func recivedInvoices(notification : Notification){
        if let data = (notification.userInfo!  as? [String: [InvoiceModel]]){
            Logger.shared.logDebug("recivedInvoices")
            items = data["invoices"]
            tableView.reloadData()
        }
    }
}

// MARK: Table View (items)
extension InvoicesViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "invoiceCell", for: indexPath) as! InvoiceTableViewCell
        if let  item =  items?[indexPath.item]{
        
            cell.clientNameLBL.text = "Client Name: \(item.client?.uName ?? "")"
        cell.dateLBL.text = "Date: \(item.date)"
        cell.invoiceNumberLBL.text = "Invoice #\(item.invoiceNumber)"
        cell.totalPriceLBL.text = "Price: \(item.totalPrice)"
        cell.invoice = item

        
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell =  tableView.cellForRow(at: indexPath) as! InvoiceTableViewCell
        Logger.shared.logDebug(cell.invoiceNumberLBL?.text ?? "nil")
        
    }
    

    
    
}
