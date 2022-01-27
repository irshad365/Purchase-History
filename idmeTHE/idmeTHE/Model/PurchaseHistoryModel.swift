//
//  PurchaseHistoryModel.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import Foundation

typealias Purchases = [Purchase]

struct Purchase: Codable, Hashable {
    let image: URL
    private let purchaseDate: Date?
    private let refundDate: Date?
    let itemName, serial: String
    let refundAmount: String?
    let price: String?
    let purchaseDescription: String
    
    enum CodingKeys: String, CodingKey {
        case image
        case purchaseDate = "purchase_date"
        case itemName = "item_name"
        case price, serial
        case purchaseDescription = "description"
        case refundDate = "refund_date"
        case refundAmount = "refund_amt"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(serial)
    }
}

extension Purchase {
    
    var date: Date? {
        if let purchaseDate = self.purchaseDate {
            return purchaseDate
        } else if let returnDate = self.refundDate {
            return returnDate
        }
        return nil
    }
    
    var priceAmount: String? {
        if let price = self.price {
            return price
        } else if let refundAmount = self.refundAmount {
            return refundAmount
        }
        return nil
    }
    
    var type: PurchaseType {
        if let _ = self.price {
            return .purchae
        } else  {
            return .refund
        }
    }
    
    var monthNyear: String {
        if let date = self.date {
            let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
            return "\(calendarDate.month ?? 0) + \(calendarDate.year ?? 0)"
        }
        return ""
    }
    
}

enum PurchaseType {
    case purchae
    case refund
}

extension Purchase {
  init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      
      purchaseDate = try container.decodeIfPresent(Date.self, forKey: .purchaseDate)
      refundDate = try container.decodeIfPresent(Date.self, forKey: .refundDate)
      image = try container.decode(URL.self, forKey: .image)
      itemName = try container.decode(String.self, forKey: .itemName)
      price = try container.decodeIfPresent(String.self, forKey: .price)
      refundAmount = try container.decodeIfPresent(String.self, forKey: .refundAmount)

      serial = try container.decode(String.self, forKey: .serial)

      let purchaseDescriptionHtml = try container.decode(String.self, forKey: .purchaseDescription)
      purchaseDescription = purchaseDescriptionHtml.htmlDecoded
  }
}
