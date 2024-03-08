//
//  SettingsView.swift
//  Profiles
//
//  Created by Valid Mohammadi on 8.03.2024.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    
    func getAuthenticatedUser() throws {
        do {
            let user = try AuthenticationManager.shared.getAuthenticatedUser()
        }
        catch {
            print("Error while getting authenticated user in settingsView")
        }
        
    }
    
    func signOut()  throws {
        do {
            try AuthenticationManager.shared.SignOut()
        }
        catch {
            print("Error while signing out in settingsView")
        }
        
    }
    
    func deleteUser() throws {
        do {
            try AuthenticationManager.shared.DeleteUser()
        }
        catch {
            print("Error while deleting user")
        }
    }
    
}

struct SettingsView: View {
    
    @ObservedObject private var viewModel = SettingsViewModel()
    @State private var showAlert: Bool = false
    @Binding var showProfileView: Bool
    
    
    
    var body: some View {
        List {
            Button("Log Out") {
                Task{
                    try viewModel.getAuthenticatedUser()
                    try viewModel.signOut()
                     showProfileView.toggle()
                }
                
            }
            
            Button {
                showAlert.toggle()
                
            }
        label: {
                Text("Delete User")
                .foregroundColor(.red)
                
            }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Delete User"),
                message: Text("Are you sure you want to delete this user?"),
                primaryButton: .destructive(Text("Delete")) {
                    Task {
                        try viewModel.deleteUser()
                       showProfileView.toggle()
                        
                    }
                },
                secondaryButton: .cancel()
            )
        }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView(showProfileView: .constant(false))
}
