//
//  TableViewCell.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/26/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCategories: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
    
    var buttonAction: (() -> Void)?
    var plusAction: (() -> Void)?
    var minusAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAddToCart(_ sender: Any) {
        buttonAction?()
    }
    @IBAction func btnPlus(_ sender: Any) {
        plusAction?()
    }
    @IBAction func btnMinus(_ sender: Any) {
        minusAction?()
    }
}
