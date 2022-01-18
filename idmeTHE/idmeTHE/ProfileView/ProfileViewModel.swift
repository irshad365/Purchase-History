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
        
        guard let url = URL(string: userProfile) else {
            self.result = .failure("error")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Profile.self, from: data) {
                self.result = .success(decodedResponse)
            }
        } catch {
            self.result = .failure("error")
        }
    }
    
    
}
