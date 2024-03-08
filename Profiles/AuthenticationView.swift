//
//  AuthenticationView.swift
//  Profiles
//
//  Created by Valid Mohammadi on 23.02.2024.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInWithGoogle() async throws {
        
        let helper = SignInWithGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
    
}


struct AuthenticationView: View {
    
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showProfileView: Bool
    var body: some View {
        VStack{
            
            NavigationLink {
                SignUpWithEmailView(showProfileView: $showProfileView)
            } label: {
                Text("Sign Up with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .icon, state: .normal)){
                Task{
                    do {
                        try await viewModel.signInWithGoogle()
                        showProfileView.toggle()
                    } catch {
                        print(error)
                    }
                }
            }
            .cornerRadius(10)
            
            
            
            NavigationLink {
                SignInWithEmailView(showProfileView: $showProfileView)
            } label: {
                Text("Already have account? Sign In")
                    .foregroundColor(.blue)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            }


            
        }
        .padding()
        .navigationTitle("Welcome")
        Spacer()
    }
}

#Preview {
    NavigationStack{
        AuthenticationView(showProfileView: .constant(false))
    }
}
