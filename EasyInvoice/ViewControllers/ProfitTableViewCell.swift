//
//  ProfitTableViewCell.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 21/07/2021.
//

import UIKit

class ProfitTableViewCell: UITableViewCell {

    @IBOutlet weak var amountLBL: PaddingLabel!
    @IBOutlet weak var monthLBL: PaddingLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        amountLBL.localizeLable()
        monthLBL.localizeLable()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
