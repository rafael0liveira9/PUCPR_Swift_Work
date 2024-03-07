//
//  Trabalho_de_iosApp.swift
//  Trabalho de ios
//
//  Created by user240648 on 2/25/24.
//

import SwiftUI
import Firebase

@main
struct Trabalho_de_iosApp: App {
    @StateObject var authAdapter = AuthAdapter()
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authAdapter)
        }
    }
}

