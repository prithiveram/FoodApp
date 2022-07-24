//
//  FoodTableViewCell.swift
//  foodApp
//
//  Created by Mac-mini 2 on 21/07/22.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    @IBOutlet weak var btnAdd : UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddOns: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgDish: UIImageView!
    @IBOutlet weak var cardView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 20;
        btnAdd.setTitle("Add", for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
