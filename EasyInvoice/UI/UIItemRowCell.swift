//
//  UIItemRowCell.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 27/07/2021.
//

import UIKit

class UIItemRowCell: UITableViewCell {
    @IBOutlet weak var priceWithTaxLBL: UILabel!
    @IBOutlet weak var priceWithoutTaxLBL: UILabel!
    @IBOutlet weak var discountLBL: UILabel!
    @IBOutlet weak var quantityLBL: UILabel!
    @IBOutlet weak var unitPriceLBL: UILabel!
    
    @IBOutlet weak var desLBL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
