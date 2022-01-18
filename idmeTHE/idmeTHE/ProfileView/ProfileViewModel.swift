//
//  ProfileViewModel.swift
//  idmeTHE
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import Foundation
import Combine

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var result: AsyncResponse<Profile> = .empty
    
    func loadData() async {
        self.result = .inProgress
        self.result = await Session.shared.load(urlString: userProfile, dataType: Profile.self)
    }
}
