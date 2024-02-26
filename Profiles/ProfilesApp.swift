//
//  ProfilesApp.swift
//  Profiles
//
//  Created by Valid Mohammadi on 23.02.2024.
//

import SwiftUI
import Firebase


@main
struct ProfilesApp: App {
    
    init(){
        FirebaseApp.configure()
        print("Configured Firebase!")
    }
    
    var body: some Scene {
        WindowGroup {
           RootView()
        }
    }
}
