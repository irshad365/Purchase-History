//
//  PurchaseHistoryView.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import SwiftUI

struct PurchaseHistoryView: View {
    @StateObject var viewModel = PurchaseHistoryViewModel()
    
    var body: some View {
        Group {
            switch viewModel.result {
            case .empty:
                EmptyView()
            case .inProgress:
                ProgressView()
            case let .success(purchases):
                List(purchases, id: \.serial) { purchase in
                    Text(purchase.itemName)
                }
            case let .failure(error):
                Text(error)
            }
        }
        .task {
            await viewModel.loadData()
        }
        .refreshable {
            await viewModel.loadData()
        }
    }
}

struct PurchaseHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseHistoryView()
    }
}
