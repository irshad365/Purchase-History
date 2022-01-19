//
//  IDAsyncImageView.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/19/22.
//

import SwiftUI

struct IDAsyncImageView: View {
    let urlString: String
    
    var body: some View {
        AsyncImage(url: URL(string: urlString), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
            case .failure(_):
                Image("placeholder")
                    .resizable()
            case .empty:
                Image("placeholder")
                    .resizable()
            @unknown default:
                ProgressView()
            }
        }
        .clipShape(Circle())
        .scaledToFit()
    }
}

struct IDAsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        IDAsyncImageView(urlString: "https://i.imgur.com/i4f37c8.jpg")
            .background(.green)
            .frame(width: 100, height: 100, alignment: .center)
    }
}
