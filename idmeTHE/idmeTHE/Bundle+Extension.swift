//
//  InfoHelper.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import Foundation

extension Bundle {
    var baseURL: String {
        valueFor(key: "baseURL") ?? ""
    }
    
    func valueFor(key: String) -> String? {
        infoDictionary?[key] as? String
    }
}
