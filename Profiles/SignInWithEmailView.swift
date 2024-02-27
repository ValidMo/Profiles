//
//  SignInWithEmail.swift
//  Profiles
//
//  Created by Valid Mohammadi on 26.02.2024.
//

import SwiftUI

@MainActor
final class SignInWithEmailViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signInWithEmail() async throws {
        guard !email.isEmpty && !password.isEmpty
        else {
            print("User of Password Field is Empty")
            return
        }
        try await AuthenticationManager.shared.signIn(email: email, password: password)
        
    }
}

struct SignInWithEmailView: View {
    
    @StateObject var viewModel = SignInWithEmailViewModel()
    @Binding var showProfileView: Bool
    @State private var isLoading: Bool = false
    @State private var logInErrorMessage: Bool = false
    
    
    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                guard !viewModel.email.isEmpty, !viewModel.password.isEmpty 
                else {
                    logInErrorMessage.toggle()
                    return
                }
                isLoading.toggle()
                Task{
                    do {
                        try await viewModel.signInWithEmail()
                        showProfileView.toggle()
                        isLoading.toggle()
                    } catch {
                        print("Sign-in failed: \(error)")
                        isLoading.toggle()
                        logInErrorMessage.toggle()
                    }
                }
            }  label: {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                }

                
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .disabled(isLoading)
            .opacity(isLoading ? 0.5 : 1)
            
            Text("Sorry your password or username was incorrect. Please double check.")
                .foregroundStyle(Color.red)
                .opacity(logInErrorMessage ? 1 : 0)
            
            
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Sign In with Email")
    }
}


#Preview {
    SignInWithEmailView(showProfileView: .constant(false))
}
