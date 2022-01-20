//
//  PurchaseHistoryView.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import SwiftUI


//TODO: - Add search and sort

struct PurchasesListView: View {
    let purchases: Purchases
    
    var filteredPurchases: Purchases {
        if searchText.isEmpty {
            return purchases
        } else {
            return purchases.filter { $0.itemName.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    @State private var searchText = ""

    var body: some View {
        List(filteredPurchases.sorted{$0.purchaseDate > $1.purchaseDate}, id: \.purchaseDate) { purchase in
            PurchasesRowView(purchase: purchase)
        }
        .listStyle(.plain)
        .searchable(text: $searchText)
    }
}

struct PurchaseHistoryView: View {
    @StateObject var viewModel = PurchaseHistoryViewModel()
    @State private var showingSheet = false
    
    var body: some View {
        Group {
            switch viewModel.result {
            case .empty:
                ProgressView()
            case .inProgress:
                ProgressView()
            case let .success(purchases):
                PurchasesListView(purchases: purchases)
            case let .failure(error):
                Text(error)
            }
        }
        .sheet(isPresented: $showingSheet, content: {
           SheetView()
        })
        .navigationBarTitle(Text("PURCHASES"), displayMode: .inline)
        .navigationBarItems(
            trailing:
                Button {
                    showingSheet.toggle()
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundColor(.black)
                }
        )
        .task {
            await viewModel.loadData()
        }
    }
}

struct PurchaseHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let purchaseArray = [
            Purchase(image: URL(string:"https://picsum.photos/id/0/200")!, purchaseDate: Date.now, itemName: "back-end generating alarm test long string", price: "234.00", serial: "5003330362", purchaseDescription: "I&#x27;ll connect the virtual SSL matrix, that should array the SAS matrix!"),
            Purchase(image: URL(string:"https://picsum.photos/id/1/200")!, purchaseDate: Date.now, itemName: "online copying firewall", price: "569.00", serial: "1058368307", purchaseDescription: "I&#x27;ll synthesize the mobile THX matrix, that should bus the HDD transmitter!")
        ]
        
        Group {
            NavigationView{
                PurchaseHistoryView()
            }
            
            NavigationView {
                PurchasesListView(purchases: purchaseArray)
            }
            
            NavigationView {
                PurchasesListView(purchases: purchaseArray)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
