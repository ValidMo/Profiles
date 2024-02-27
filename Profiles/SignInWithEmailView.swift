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
    
    func signInWithEmail() {
        guard !email.isEmpty && !password.isEmpty
        else {
            print("User of Password Field is Empty")
            return
        }
        Task{
            do {
                
            } catch {
                
            }
        }
    
}

struct SignInWithEmail: View {
    
    @StateObject var viewModel = SignInWithEmailViewModel()
    
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
                viewModel.signInWithEmail()
            } label: {
                Text("SignIn")
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
}

#Preview {
    SignInWithEmail()
}
