//
//  PurchaseHistoryViewModel.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import Foundation
import Combine

@MainActor
class PurchaseHistoryViewModel: ObservableObject {
    @Published var result: AsyncResponse<Purchases> = .empty
    
    var PurchaseArray = Purchases()
    
    func loadData() async {
        self.result = .inProgress
        let result = await Session.shared.load(urlString: purchaseHistory, dataType: Purchases.self)
        
        switch result {
        case let .success(Purchases):
            PurchaseArray.append(contentsOf: Purchases)
            
        default:
            self.result = result
        }
        
        let refund = await Session.shared.load(urlString: refund, dataType: Purchases.self)
        
        switch refund {
        case let .success(Purchases):
            PurchaseArray.append(contentsOf: Purchases)
            
        default:
            self.result = result
        }
        
        self.result = .success(PurchaseArray)
        
    }
}

