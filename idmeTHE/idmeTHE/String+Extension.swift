//
//  String+Extension.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/19/22.
//

import Foundation

extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string

        return decoded ?? self
    }
    
    var toPhoneNumber: String {
        return self.replacingOccurrences(of: "(\\d{1})(\\d{3})(\\d{3})(\\d+)", with: "+$1 ($2) $3-$4", options: .regularExpression, range: nil)
    }
}
