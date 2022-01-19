//
//  PurchaseHistoryModel.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import Foundation

typealias Purchases = [Purchase]

struct Purchase: Codable {
    let image: URL
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

extension Purchase {
  init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      
      purchaseDate = try container.decode(Date.self, forKey: .purchaseDate)
      image = try container.decode(URL.self, forKey: .image)
      itemName = try container.decode(String.self, forKey: .itemName)
      price = try container.decode(String.self, forKey: .price)
      serial = try container.decode(String.self, forKey: .serial)

      let purchaseDescriptionHtml = try container.decode(String.self, forKey: .purchaseDescription)
      purchaseDescription = purchaseDescriptionHtml.htmlDecoded
  }
}
