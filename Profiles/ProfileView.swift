//
//  SettingsView.swift
//  Profiles
//
//  Created by Valid Mohammadi on 25.02.2024.
//

import SwiftUI


@MainActor
final class ProfileViewModel: ObservableObject {
    
    func getAuthenticatedUser() throws  {
        do{
            let user = try AuthenticationManager.shared.getAuthenticatedUser()
            print(user)
            print("Got User")
            
        } catch {
            print("No User")
        }
        
    }
    
    func SignOut() throws {
        do {
            try AuthenticationManager.shared.SignOut()
            print("Signed Out")
        } catch {
            print("Error While Signing Out")
        }
    }
    
}

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showProfileView: Bool
    var body: some View {
        List {
            
            Button("Log Out") {
                Task {
                    try viewModel.getAuthenticatedUser()
                    try viewModel.SignOut()
                    showProfileView.toggle()
                }
                
            }
        }
        .onChange(of: showProfileView){
            Task {
                    try viewModel.getAuthenticatedUser()
            }
        }
        .navigationTitle("Profile")
    }
    
    
}


#Preview {
    NavigationStack{
        ProfileView(showProfileView: .constant(false))
    }
    
}
