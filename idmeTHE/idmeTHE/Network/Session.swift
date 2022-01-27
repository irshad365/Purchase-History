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
            return .failure("url in bundle error")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            
            if let decodedResponse = try? decoder.decode(dataType, from: data) {
                return .success(decodedResponse)
            } else {
                return .failure("response data error")
            }
        } catch {
            return .failure("server error")
        }
    }
    
}

let userProfile = "profile/U13023932"
let purchaseHistory = "purchases/U13023932?page=1"
let refund = "refunds/U13023932"
