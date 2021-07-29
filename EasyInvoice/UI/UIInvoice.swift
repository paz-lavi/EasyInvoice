//
//  UIInvoice.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 27/07/2021.
//

import UIKit

class UIInvoice: UIView {
    @IBOutlet var contentView: UIView!
    //    @IBOutlet weak var signatureIMG: UIImageView!
//    @IBOutlet weak var signatureLBL: UILabel!
//    @IBOutlet weak var mainTable: UITableView!
//    @IBOutlet weak var cAddressLBL: UILabel!
//    @IBOutlet weak var cEmailLBL: UILabel!
//    @IBOutlet weak var cPhoneLBL: UILabel!
//    @IBOutlet weak var cNameLBL: UILabel!
//    @IBOutlet weak var originalLBL: UILabel!
//    @IBOutlet weak var dateLBL: UILabel!
//    @IBOutlet weak var invoiceLBL: UILabel!
    @IBOutlet weak var typeLBL: UILabel!
//    @IBOutlet weak var businessAddressLBL: UILabel!
    @IBOutlet weak var businessPhoneLBL: UILabel!
    @IBOutlet weak var businessNumberLBL: UILabel!
//    @IBOutlet weak var businessNumberLBL: UILabel!
//    @IBOutlet weak var businessPhoneLBL: UILabel!
//    //    @IBOutlet weak var businessNameLBL: UILabel!
    @IBOutlet weak var businessAddressLBL: UILabel!
    @IBOutlet weak var businessNameLBL: UILabel!
//    @IBOutlet weak var typeLBL: UILabel!
//    //    @IBOutlet weak var logoIMG: UIImageView!
    @IBOutlet weak var invoiceLBL: UILabel!
    @IBOutlet weak var logoIMG: UIImageView!
    @IBOutlet weak var dateLBL: UILabel!
    @IBOutlet weak var originalLBL: UILabel!
    @IBOutlet weak var cNameLBL: UILabel!
    @IBOutlet weak var cPhoneLBL: UILabel!
    @IBOutlet weak var cEmailLBL: UILabel!
    @IBOutlet weak var cAddressLBL: UILabel!
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var signatureIMG: UIImageView!
    @IBOutlet weak var signatureLBL: UILabel!
    var items : [InvoiceItem] = []
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
 
    override init(frame: CGRect){
        super.init(frame: frame)

        commonInit()
    }
    

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        
    }
    
    private func commonInit(){
        Logger.shared.logDebug("commonInit")
        Bundle.main.loadNibNamed("UIInvoice", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        mainTable.delegate = self
        mainTable.dataSource = self
        signatureLBL.localizeLable()
        let nib = UINib(nibName: "UIItemRowCell", bundle: nil)
      mainTable.register(nib, forCellReuseIdentifier: "UIItemRow")

    }
    
    func setItems(items : [InvoiceItem]){
        self.items = items
    self.mainTable.reloadData()
    }
    
    func getQuentity() -> Int{
        var c  = 0
        for item in items{
            c += item.quantity
        }
        return c
    }
    func getPriceWithTax() -> Double{
        var c  = 0.0
        for item in items{
            c += item.totalWithTax
        }
        return c
    }
    func getPriceWithoutTax() -> Double{
        var c  = 0.0
        for item in items{
            c += item.totalWithoutTax
        }
        return c
    }
    
    func getDiscount() -> Double{
        var c  = 0.0
        for item in items{
            c += item.discountAnount
        }
        return c
    }
}

// MARK: Table View (items)
extension UIInvoice : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 2
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UIItemRow") as! UIItemRowCell
        if indexPath.item == 0 {
            cell.desLBL.text =  cell.desLBL.text?.localize
            cell.discountLBL.text =   cell.discountLBL.text?.localize
            cell.unitPriceLBL.text =   cell.unitPriceLBL.text?.localize
            cell.quantityLBL.text =  cell.quantityLBL.text?.localize
            cell.priceWithoutTaxLBL.text = cell.priceWithoutTaxLBL.text?.localize
            cell.priceWithTaxLBL.text =   cell.priceWithTaxLBL.text?.localize
        }else if indexPath.item == items.count + 1 {
            cell.desLBL.backgroundColor = UIColor.lightGray
            cell.unitPriceLBL.backgroundColor = UIColor.lightGray
            cell.quantityLBL.backgroundColor = UIColor.lightGray
            cell.priceWithoutTaxLBL.backgroundColor = UIColor.lightGray
            cell.priceWithTaxLBL.backgroundColor = UIColor.lightGray
            cell.discountLBL.backgroundColor = UIColor.lightGray
            cell.discountLBL.text = getDiscount().stringValue
            cell.desLBL.text =  "total"
            cell.unitPriceLBL.text =   ""
            cell.quantityLBL.text =  String(getQuentity())
            cell.priceWithoutTaxLBL.text = getPriceWithoutTax().stringValue
            cell.priceWithTaxLBL.text =   getPriceWithTax().stringValue
            
        }else{
            let item =  items[indexPath.item - 1 ]
            cell.desLBL.text = item.itemDescription
            cell.discountLBL.text = item.discountAnount.stringValue
            cell.unitPriceLBL.text = item.unitCost.stringValue
            cell.quantityLBL.text = item.quantity.stringValue
            cell.priceWithoutTaxLBL.text = item.totalWithoutTax.stringValue
            cell.priceWithTaxLBL.text = item.totalWithTax.stringValue
        }
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell =  tableView.cellForRow(at: indexPath) as! UIItemRow
        
    }

    
}
