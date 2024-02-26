//
//  AuthenticationView.swift
//  Profiles
//
//  Created by Valid Mohammadi on 23.02.2024.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var showSignUpView: Bool
    var body: some View {
        VStack{
            
            NavigationLink {
                SignUpEmailView()
            } label: {
                Text("Sign Up with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
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
        AuthenticationView(showSignUpView: .constant(false))
    }
}
