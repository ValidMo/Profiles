//
//  RootView.swift
//  Profiles
//
//  Created by Valid Mohammadi on 25.02.2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignUpView: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                ProfileView(showSignUpView: $showSignUpView)
            }
        }
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignUpView = (authUser == nil)
        }
        .fullScreenCover(isPresented: $showSignUpView) {
            NavigationStack{
                AuthenticationView(showSignUpView: $showSignUpView)
            }
        }
    }
}

#Preview {
    RootView()
}
