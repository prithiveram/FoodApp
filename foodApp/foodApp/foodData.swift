//
//  foodData.swift
//  foodApp
//
//  Created by Mac-mini 2 on 21/07/22.
//

import Foundation

struct FoodDetails: Codable {
    let id: String
    let img: String
    let name, dsc: String
    let price: Double
    let rate: Int
    let country: String
}


