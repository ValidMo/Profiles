//
//  SignInWithGoogleHelper.swift
//  Profiles
//
//  Created by Valid Mohammadi on 7.03.2024.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    let idToken: String
    let accesToken: String
}

final class SignInWithGoogleHelper {
    
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel {
        
        guard let topViewController = Utilities.shared.topViewController() else {
            throw URLError(.timedOut)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topViewController)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else { throw URLError(.timedOut) }
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accesToken: accessToken)
        
        return tokens
    }
}
