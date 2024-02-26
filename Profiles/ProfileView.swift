//
//  SettingsView.swift
//  Profiles
//
//  Created by Valid Mohammadi on 25.02.2024.
//

import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    
    func SignOut() throws {
        try AuthenticationManager.shared.SignOut()
    }
    
}

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignUpView: Bool
    var body: some View {
        List {
            Button("Log Out") {
                Task {
                    do {
                        try viewModel.SignOut()
                        showSignUpView = true
                    } catch {
                        print(error)
                    }
                }
                
            }
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    NavigationStack{
        ProfileView(showSignUpView: .constant(false))
    }

}
