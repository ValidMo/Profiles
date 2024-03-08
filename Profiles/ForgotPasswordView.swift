//
//  ForgotPasswordView.swift
//  Profiles
//
//  Created by Valid Mohammadi on 4.03.2024.
//

import SwiftUI

@MainActor
class ForgotPasswordViewModel: ObservableObject {
    
    func resetPassword(email: String) async throws {
        try await AuthenticationManager.shared.ResetPassword(email: email)
    }
    
}

struct ForgotPasswordView: View {
    
    @StateObject  var viewModel = ForgotPasswordViewModel()
    @State private var emailAddress: String = ""
    @Binding var showForgotPasswordView: Bool
    @State var showEmailEmptyError: Bool = false
    
    var body: some View {
        VStack{
            TextField("Email...", text: $emailAddress)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            Button{
                guard !emailAddress.isEmpty
                else {
                    showEmailEmptyError.toggle()
                    return
                }
                Task{
                    try await viewModel.resetPassword(email: emailAddress)
                    showForgotPasswordView.toggle()
                }
            }
        label: {
            Text("Reset")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
        }
            
            Text("Email field can not be empty")
                .foregroundStyle(Color.red)
                .opacity(showEmailEmptyError ? 1 : 0)
        }
        .padding()
        
        Spacer()
    }
    
}


