//
//  SignInEmailView.swift
//  Profiles
//
//  Created by Valid Mohammadi on 23.02.2024.
//

import SwiftUI


@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signUpWithEmail() {
        guard !email.isEmpty, !password.isEmpty else {
            print("no email or password is found")
            return
        }
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
            } catch {
                print("Error: \(error)")
                
            }
        }
    }
    
}

struct SignUpWithEmailView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    
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
                viewModel.signUpWithEmail()
            } label: {
                Text("SignUp")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()

        }
        .padding()
        .navigationTitle("SignUp with Email")
    }
}

#Preview {
    NavigationStack{
        SignUpWithEmailView()
    }
}
