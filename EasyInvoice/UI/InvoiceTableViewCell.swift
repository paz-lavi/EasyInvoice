//
//  InvoiceTableViewCell.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 29/07/2021.
//

import UIKit

class InvoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLBL: UILabel!
    @IBOutlet weak var clientNameLBL: UILabel!
    @IBOutlet weak var totalPriceLBL: UILabel!
    @IBOutlet weak var invoiceNumberLBL: UILabel!
    var invoice : InvoiceModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
