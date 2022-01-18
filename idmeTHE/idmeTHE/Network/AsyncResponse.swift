//
//  AsyncResponse.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import Foundation

enum AsyncResponse<Success> {
    case empty
    case inProgress
    case success(Success)
    case failure(String)
}
