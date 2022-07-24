//
//  FoodManagerApi.swift
//  foodApp
//
//  Created by Mac-mini 2 on 21/07/22.
//

import Foundation

protocol foodManagerDelegate{
    func didUpdateData(foodDetails: [FoodDetails])
}

struct FoodManagerApi{
    
    let urlString = "https://ig-food-menus.herokuapp.com/burgers"
    var delegate : foodManagerDelegate?
    var datas = [FoodDetails]()
    
    func fetchData(){
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data,response,error) in
                if error != nil{
                    print(error)
                    return
                }
                if let safeData = data{
                    if let foodData =  self.parseJson(foodData:safeData){
                        self.delegate?.didUpdateData(foodDetails: foodData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(foodData: Data) -> [FoodDetails]? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode([FoodDetails].self, from: foodData)
            return decodedData
        }catch{
            print(error)
            return nil
        }
    }
}
