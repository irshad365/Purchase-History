//
//  PurchaseHistoryModel.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import Foundation

typealias Purchases = [Purchase]

struct Purchase: Codable {
    let image: String
    let purchaseDate: Date
    let itemName, price, serial: String
    let purchaseDescription: String

    
    enum CodingKeys: String, CodingKey {
        case image
        case purchaseDate = "purchase_date"
        case itemName = "item_name"
        case price, serial
        case purchaseDescription = "description"
    }
}
