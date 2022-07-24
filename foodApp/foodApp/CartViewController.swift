//
//  CardViewController.swift
//  foodApp
//
//  Created by Mac-mini 2 on 23/07/22.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var foodListView: UITableView!
    @IBOutlet weak var btnCheckout : UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblamount: UILabel!
    
    var cartDataArray = [FoodDetails]()
    var quantityCount = 1
    var totalPrice = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData(){
        let cartData = UserDefaults.standard.data(forKey: "cartDetails")
        self.cartDataArray = try! JSONDecoder().decode([FoodDetails].self, from: cartData!)
        getTotalPrice()
        lblHeading.text = "Your Cart"
        lblPrice.text = "Total: ₹"
        lblamount.text = String(totalPrice)    }
    
    func getTotalPrice(){
        for items in cartDataArray{
            totalPrice += items.price
        }
    }

    @objc func btnPlus_Click(sender: UIButton){
        let senderValue = Int(sender.accessibilityValue!)
        let index = IndexPath(item: senderValue!, section: 0)
        self.quantityCount += 1
        self.foodListView.reloadRows(at: [index], with: .none)
    }
    
    @objc func btnMinus_Click(sender: UIButton){
        let senderValue = Int(sender.accessibilityValue!)
        let index = IndexPath(item: senderValue!, section: 0)
        self.quantityCount -= 1
        self.foodListView.reloadRows(at: [index], with: .none)
    }
}

extension CartViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = foodListView.dequeueReusableCell(withIdentifier: "CartTableView") as! CartTableViewCell
        cell.lblName.text = cartDataArray[indexPath.row].name
        cell.lblAddOns.text = cartDataArray[indexPath.row].dsc
        cell.lblPrice.text = "₹" + String(cartDataArray[indexPath.row].price)
        cell.lblQuantity.text = String(self.quantityCount)
        let imageUrl = self.cartDataArray[indexPath.row].img
        let imageData = URL(string: imageUrl)
        let image = try! Data(contentsOf: imageData!)
        cell.imgDish.image = image.base64EncodedString().toImage()
        cell.btnPlus.accessibilityValue = String(indexPath.row)
        cell.btnMinus.accessibilityValue = String(indexPath.row)
        cell.btnPlus.addTarget(self, action: #selector(self.btnPlus_Click(sender:)), for: .touchUpInside)
        cell.btnMinus.addTarget(self, action: #selector(self.btnMinus_Click(sender:)), for: .touchUpInside)
        return cell
    }
    
    
}
