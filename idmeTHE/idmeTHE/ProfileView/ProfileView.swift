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
        VStack(spacing: 40) {
            VStack(spacing: 0) {
                IDAsyncImageView(url: profile.image)
                    .frame(width: 200, height: 200, alignment: .center)
                Text(profile.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            VStack(spacing: 20) {
                HStack {
                    Text("PERSONAL")
                        .font(.callout)
                        .foregroundColor(Color.gray)
                        
                    Spacer()
                }
                
                ProfileDataRowView(title: "USER_NAME", message: profile.userName)
                
                ProfileDataRowView(title: "FULL_NAME", message: profile.fullName)
                
                ProfileDataRowView(title: "PHONE_NUMBER", message: profile.phoneNumber.toPhoneNumber)
                
                ProfileDataRowView(title: "REGISTRATION_DATE", message: profile.registration.stringValue)
            }
            
            NavigationLink(destination: PurchaseHistoryView()) {
                ZStack {
                    Capsule()
                        .frame(height: 50.0)
                    Text("VIEW_PURCHASES")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding()
    }
}

struct ProfileDataRowView: View {
    var title: LocalizedStringKey
    var message: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title3)
            Spacer()
            Text(message)
                .foregroundColor(Color.gray)
        }
    }
}


struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
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
        }
        .task {
            await viewModel.loadData()
        }
    }
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let profile = Profile(name: "Jennifer Smith",
                              userName: "@jennsmith",
                              fullName: "Jennifer Avie Smith",
                              phoneNumber: "17025555555",
                              registration: Date.now,
                              image: URL(string:"https://i.imgur.com/i4f37c8.jpg")!)
        
        Group {
            NavigationView {
                ProfileModelView(profile: profile)
            }
            
            NavigationView {
                ProfileModelView(profile: profile)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
