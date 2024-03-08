//
//  AuthenticationManager.swift
//  Profiles
//
//  Created by Valid Mohammadi on 23.02.2024.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
    }
    
    init(uid: String, email: String)
    {
        self.uid = uid
        self.email = email
    }
    
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init(){}
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
        
        
    }
    
    @discardableResult
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
        
    }
    
    
    func SignOut() throws {
        try Auth.auth().signOut()
    }
    
    func DeleteUser() throws {
        Auth.auth().currentUser?.delete()
    }
    
    func ResetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func signIn(with credental: AuthCredential) async throws -> AuthDataResultModel {
       let authDataRsult = try await Auth.auth().signIn(with: credental)
        return AuthDataResultModel(user: authDataRsult.user)
    }
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accesToken)
        return try await signIn(with: credential)
    }
    
}
