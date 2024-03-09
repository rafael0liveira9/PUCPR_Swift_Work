//
//  ContentView.swift
//  Trabalho de ios
//
//  Created by user240648 on 2/25/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authAdapter: AuthAdapter
    
    var body: some View {
        Group {
            if authAdapter.userSession != nil {
                HomeView()
            }else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
