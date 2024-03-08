//
//  SignInEmailView.swift
//  Profiles
//
//  Created by Valid Mohammadi on 23.02.2024.
//

import SwiftUI


@MainActor
final class SignUpViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signUpWithEmail() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("no email or password is found")
            return
        }
        
        try await AuthenticationManager.shared.createUser(email: email, password: password)
        print("Successfully Created User")
        
    }
    
    func signInWithEmail() async throws {
        guard !email.isEmpty && !password.isEmpty
        else {
            print("User of Password Field is Empty")
            return
        }
        try await AuthenticationManager.shared.signIn(email: email, password: password)
        print("Successfully Signed In")
    }
    
}

struct SignUpWithEmailView: View {
    
    @StateObject private var viewModel = SignUpViewModel()
    @Binding var showProfileView: Bool
    @State private var signUpErrorMessage: Bool = false
    @State private var isLoading: Bool = false
    
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
                
                
                guard !viewModel.email.isEmpty, !viewModel.password.isEmpty else {
                    signUpErrorMessage.toggle()
                    return
                }
                isLoading.toggle()
                
                Task {
                    do{
                        try await viewModel.signUpWithEmail()
                        
                    } catch {
                        signUpErrorMessage.toggle()
                        print("Error while creating user: \(error)")
                        isLoading.toggle()
                    }
                    
                    do {
                        try await viewModel.signInWithEmail()
                        showProfileView.toggle()
                        isLoading.toggle()
                    } catch {
                        print("Error while logging in: \(error)")
                    }
                }
            } label: {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Sign Up")
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
            
            Text("Error while creating user.")
                .foregroundStyle(Color.red)
                .opacity(signUpErrorMessage ? 1 : 0)
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("SignUp with Email")
    }
}

#Preview {
    NavigationStack{
        SignUpWithEmailView(showProfileView: .constant(false))
    }
}
