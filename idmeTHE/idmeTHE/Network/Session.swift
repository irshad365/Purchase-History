//
//  Session.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

let userProfile = "https://idme-takehome.proxy.beeceptor.com/profile/U13023932"

let purchaseHistory = "https://idme-takehome.proxy.beeceptor.com/purchases/U13023932?page=1"

enum AsyncResponse<Success> {
    case empty
    case inProgress
    case success(Success)
    case failure(String)
}
