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
    
    func loadData() async {
        self.result = .inProgress
        self.result = await Session.shared.load(urlString: purchaseHistory, dataType: Purchases.self)
    }
}

