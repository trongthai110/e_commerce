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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAddToCart(_ sender: Any) {
        print("Add to cart")
    }
}
