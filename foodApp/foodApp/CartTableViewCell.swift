//
//  CartTableViewCell.swift
//  foodApp
//
//  Created by Mac-mini 2 on 23/07/22.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddOns: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var imgDish: UIImageView!
    @IBOutlet weak var cardView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 10;
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
