//
//  PurchaseHistoryView.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import SwiftUI

struct PurchasesRowView: View {
    let purchase: Purchase
    @State var expand = false
    
    var image: some View {
        VStack {
            IDAsyncImageView(urlString: purchase.image)
                .frame(width: 50, height: 50, alignment: .center)
                .padding(.top, 8)
            Spacer()
        }
    }
    
    var title: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8.0) {
                //TODO: - fix single line title bug
                Text(purchase.itemName)
                    .font(.title3)
                Text(purchase.purchaseDate.stringValue)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            
            Text("$")+Text(purchase.price)
        }
    }
    
    var moreDetails: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text("SERIAL") + Text(": ") + Text(purchase.serial)
            Text("DESCRIPTION") + Text(":")
            Text(purchase.purchaseDescription)
                .fixedSize(horizontal: false, vertical: true)
        }
        .font(.subheadline)
        .foregroundColor(Color.gray)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            image
            
            VStack(alignment: .leading, spacing: 8.0) {
                title
                    .onTapGesture {
                        expand.toggle()
                    }
                
                if expand == true {
                    moreDetails

                }
            }
        }
        .padding(.bottom, 8)
    }
}

struct PurchasesModelView: View {
    let purchases: Purchases
    
    var body: some View {
        List(purchases.sorted{$0.purchaseDate > $1.purchaseDate}, id: \.purchaseDate) { purchase in
            PurchasesRowView(purchase: purchase)
        }
        .listStyle(GroupedListStyle())
    }
}

struct PurchaseHistoryView: View {
    @StateObject var viewModel = PurchaseHistoryViewModel()
    
    var body: some View {
        Group {
            switch viewModel.result {
            case .empty:
                ProgressView()
            case .inProgress:
                ProgressView()
            case let .success(purchases):
                PurchasesModelView(purchases: purchases)
            case let .failure(error):
                Text(error)
            }
        }
        .navigationTitle("PURCHASES")
        .task {
            await viewModel.loadData()
        }
    }
}

struct PurchaseHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let purchaseArray = [
            Purchase(image: "https://picsum.photos/id/0/200", purchaseDate: Date.now, itemName: "back-end generating alarm test long string", price: "234.00", serial: "5003330362", purchaseDescription: "I&#x27;ll connect the virtual SSL matrix, that should array the SAS matrix!"),
            Purchase(image: "https://picsum.photos/id/1/200", purchaseDate: Date.now, itemName: "online copying firewall", price: "569.00", serial: "1058368307", purchaseDescription: "I&#x27;ll synthesize the mobile THX matrix, that should bus the HDD transmitter!")
        ]
        
        Group {
            NavigationView {
                PurchasesModelView(purchases: purchaseArray)
                    .navigationTitle("PURCHASES")
            }
            
            NavigationView {
                PurchasesModelView(purchases: purchaseArray)
                    .preferredColorScheme(.dark)
                    .navigationTitle("PURCHASES")
            }
        }
    }
}
