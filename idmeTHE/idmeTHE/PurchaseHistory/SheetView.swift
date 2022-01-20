//
//  SheetView.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/19/22.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("ABOUT_PURCHASES")
                    .font(.title)
                .fontWeight(.bold)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }
            Text("ABOUT_PURCHASES_BODY")
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding()
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
