//
//  UIItemRow.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 27/07/2021.
//

import UIKit

class UIItemRow: UITableViewCell {

//    @IBOutlet weak var priceWithTaxLBL: UILabel!
//    @IBOutlet weak var priceWithoutTaxLBL: UILabel!
//    @IBOutlet weak var discountLBL: UILabel!
//    @IBOutlet weak var quantityLBL: UILabel!
//    @IBOutlet weak var desLBL: UILabel!
//    @IBOutlet weak var unitPriceLBL: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    commonInit()
        
    }
    
    private func commonInit(){
        Logger.shared.logDebug("commonInit111")
        //let cv = Bundle.main.loadNibNamed("UIItemRow", owner: self, options: nil) as? UITableViewCell
       // self.containerView = Bundle.main.loadNibNamed("UIItemRow", owner: self, options: nil)![0] as! UIView
     //   self.addSubview(cv)
        //addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      
    }
}
