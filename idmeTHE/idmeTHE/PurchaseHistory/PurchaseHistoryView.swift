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
    
    var personsByMonth : [String: [Purchase]] {
        guard !filteredPurchases.isEmpty else { return [:] }
        return Dictionary(grouping: filteredPurchases, by: { $0.monthNyear })
    }
    
    @State private var searchText = ""

    var body: some View {
        let dict = personsByMonth
        
        let keys = dict.map{$0.key}
        
        List {
            ForEach(keys.indices ) { index in
                Section(header: Text(keys[index])+Text("sss") ) {
                    ForEach(dict[keys[index]] ?? [Purchase](), id: \.self) { purchase in
                        PurchasesRowView(purchase: purchase)
                           
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }
    
//    func calculatePrice(array: [Purchase]) {
//        var count = 0
//        for purchase in array {
//            if let amount = purchase.price {
//                count = count + amount
//            } else if let negAmount = purch
//        }
//    }
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

//struct PurchaseHistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        let purchaseArray = [
//            Purchase(image: URL(string:"https://picsum.photos/id/0/200")!, purchaseDate: Date.now, itemName: "back-end generating alarm test long string", price: "234.00", serial: "5003330362", purchaseDescription: "I&#x27;ll connect the virtual SSL matrix, that should array the SAS matrix!"),
//            Purchase(image: URL(string:"https://picsum.photos/id/1/200")!, purchaseDate: Date.now, itemName: "online copying firewall", price: "569.00", serial: "1058368307", purchaseDescription: "I&#x27;ll synthesize the mobile THX matrix, that should bus the HDD transmitter!")
//        ]
//        
//        Group {
//            NavigationView{
//                PurchaseHistoryView()
//            }
//            
//            NavigationView {
//                PurchasesListView(purchases: purchaseArray)
//            }
//            
//            NavigationView {
//                PurchasesListView(purchases: purchaseArray)
//                    .preferredColorScheme(.dark)
//            }
//        }
//    }
//}
