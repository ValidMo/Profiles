//
//  RootView.swift
//  Profiles
//
//  Created by Valid Mohammadi on 25.02.2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var showProfileView: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                ProfileView(showProfileView: $showProfileView)
            }
        }
        .onAppear{
            
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showProfileView = (authUser == nil)
        }
        .fullScreenCover(isPresented: $showProfileView) {
            NavigationStack{
                AuthenticationView(showProfileView: $showProfileView)
            }
        }
    }
}

#Preview {
    RootView()
}
