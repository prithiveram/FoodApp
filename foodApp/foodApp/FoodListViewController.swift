//
//  ViewController.swift
//  foodApp
//
//  Created by Mac-mini 2 on 21/07/22.
//

import UIKit
import CoreLocation

class FoodListViewController: UIViewController ,foodManagerDelegate, CLLocationManagerDelegate{
    
    
    
    @IBOutlet weak var foodListView: UITableView!
    @IBOutlet weak var btnCart : UIButton!
    @IBOutlet weak var lblHeading1: UILabel!
    @IBOutlet weak var lblHeading2: UILabel!
    @IBOutlet weak var imgHeading: UIImageView!
   
    
    var foodApi = FoodManagerApi()
    var FoodDatas = [FoodDetails]()
    var cartFoodDatas = [FoodDetails]()
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        foodApi.delegate = self
        loadData()
        foodApi.fetchData()
    }
    
    func loadData(){
        lblHeading1.text = "Coimbatore"
        lblHeading2.text = "TamilNadu"
        imgHeading.image = UIImage(named: "logo")
       
    }

   
    
    func didUpdateData(foodDetails: [FoodDetails]) {
        DispatchQueue.main.async {
            self.FoodDatas = foodDetails
            print(foodDetails[0].name)
            self.foodListView.reloadData()
        }
    }
    
    
    @IBAction func btnCart_Click(_ sender: Any) {
        let userDefaultFoodData = try! JSONEncoder().encode(cartFoodDatas)
        userDefaults.set(userDefaultFoodData, forKey: "cartDetails")
        let CartView = storyboard?.instantiateViewController(withIdentifier: "CartView") as!  CartViewController
        self.navigationController?.pushViewController(CartView, animated: true)
    }
    
    @objc func btnAdd_Click(sender: UIButton){
        let selectedRowNumber = Int(sender.accessibilityValue!)
        cartFoodDatas.append(FoodDatas[selectedRowNumber!])
    }
}

extension FoodListViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.FoodDatas.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = foodListView.dequeueReusableCell(withIdentifier: "FoodTableView") as! FoodTableViewCell
        if self.FoodDatas.count > 0 {
            DispatchQueue.main.async {
                cell.lblName.text = self.FoodDatas[indexPath.row].name
                cell.lblAddOns.text = self.FoodDatas[indexPath.row].dsc
                cell.lblPrice.text = "₹" + String(self.FoodDatas[indexPath.row].price)
                let imageUrl = self.FoodDatas[indexPath.row].img
                let imageData = URL(string: imageUrl)
                let image = try! Data(contentsOf: imageData!)
                cell.imgDish.image = image.base64EncodedString().toImage()
                cell.btnAdd.accessibilityValue = String(indexPath.row)
                cell.btnAdd.addTarget(self, action: #selector(self.btnAdd_Click(sender:)), for: .touchUpInside)
            }
        }
        return cell
    }
    
    
}

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
    
    
}
