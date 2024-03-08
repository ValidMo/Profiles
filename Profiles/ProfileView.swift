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
    
   
    
}

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showProfileView: Bool
    @State private var showPasswordResetSuccess: Bool = false
    
    
    
    var body: some View {
        List {
            
        
            Text("HELLOW")
            
          
            
        }
        .onChange(of: showProfileView){
            Task {
                    try viewModel.getAuthenticatedUser()
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: SettingsView(showProfileView: $showProfileView)) {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
    
    
}


#Preview {
    NavigationStack{
        ProfileView(showProfileView: .constant(false))
    }
    
}
