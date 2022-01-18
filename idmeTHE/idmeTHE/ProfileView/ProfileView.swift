//
//  ContentView.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        Group {
            switch viewModel.result {
            case .empty:
                EmptyView()
            case .inProgress:
                ProgressView()
            case let .success(profile):
                Text(profile.name)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
