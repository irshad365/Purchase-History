//
//  ContentView.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import SwiftUI


struct ProfileModelView: View {
    let profile: Profile
    
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                ProfileImageView(urlString: profile.image)
                Text(profile.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            HStack {
                Text("Personal")
                    .font(.callout)
                    .foregroundColor(Color.gray)
                    
                Spacer()
            }
        }
        .padding()
    }
    
}

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        Group {
            switch viewModel.result {
            case .empty:
                Text("")
            case .inProgress:
                ProgressView()
            case let .success(profile):
                ProfileModelView(profile: profile)
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

struct ProfileImageView: View {
    let urlString: String
    
    var body: some View {
        AsyncImage(url: URL(string: urlString), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                
            case .failure(_):
                Image("placeholder")
            case .empty:
                Image("placeholder")
            @unknown default:
                ProgressView()
            }
        }
        .clipShape(Circle())
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let profile = Profile(name: "Jennifer Smith",
                              userName: "@jennsmith",
                              fullName: "Jennifer Avie Smith",
                              phoneNumber: "17025555555",
                              registration: "2021-08-02T13:45:00.000Z",
                              image: "https://i.imgur.com/i4f37c8.jpg")
        
        Group {
            ProfileModelView(profile: profile)
            ProfileModelView(profile: profile)
                .preferredColorScheme(.dark)
        }
    }
}
