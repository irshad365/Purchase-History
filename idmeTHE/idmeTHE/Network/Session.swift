//
//  Session.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import Foundation

class Session {
    static var shared = Session()
    private init() {}
    
    func load<T>(urlString: String, dataType: T.Type) async -> AsyncResponse<T> where T: Decodable {
        let urlString = Bundle.main.baseURL + urlString
        guard let url = URL(string: urlString) else {
            return .failure("error")
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(dataType, from: data) {
                return .success(decodedResponse)
            }
        } catch {
            return .failure("error")
        }
        return .failure("error")
    }
    
}

// TODO: - move these to a propper file
let userProfile = "profile/U13023932"
let purchaseHistory = "purchases/U13023932?page=1"
