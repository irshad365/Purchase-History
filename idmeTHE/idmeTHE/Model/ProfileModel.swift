//
//  ResponseModel.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import Foundation

struct Profile: Codable {
    let name, userName, fullName, phoneNumber: String
    let registration: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case name
        case userName = "user_name"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case registration, image
    }
}
