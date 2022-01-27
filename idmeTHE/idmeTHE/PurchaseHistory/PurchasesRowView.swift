//
//  PurchasesRowView.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/19/22.
//

import SwiftUI

struct PurchasesRowView: View {
    let purchase: Purchase
    @State var expand = false
    
    var image: some View {
        IDAsyncImageView(url: purchase.image)
            .frame(width: 50, height: 50, alignment: .center)
            .accessibilityLabel("ITEM_IMAGE")
    }
    
    var title: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(purchase.itemName)
                    .font(.title3)
                
                if let date = purchase.date {
                    Text(date.stringValue)
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                }
            }
            
            Spacer()
            
            if let price = purchase.priceAmount {
                Text("$")+Text(price)
            }
            
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
        VStack(alignment: .leading, spacing: 8.0) {
            HStack(spacing: 16) {
                image
                title
                    .onTapGesture { expand.toggle() }
            }
            if expand == true {
                moreDetails
                    .padding(.leading, 66)
            }
        }
    }
}

//
//struct PurchasesRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        PurchasesRowView(purchase: Purchase(image: URL(string:"https://picsum.photos/id/1/200")!, purchaseDate: Date.now, itemName: "online copying firewall", price: "569.00", serial: "1058368307", purchaseDescription: "I&#x27;ll synthesize the mobile THX matrix, that should bus the HDD transmitter!"))
//    }
//}
