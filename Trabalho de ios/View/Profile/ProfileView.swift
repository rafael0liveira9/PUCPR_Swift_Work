//
//  ProfileView.swift
//  Trabalho de ios
//
//  Created by user240648 on 2/28/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authAdapter: AuthAdapter
    
    var body: some View {
        
        if let user = authAdapter.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height:72)
                            .background(Color(.systemGray3))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text(user.name)
                                .fontWeight(.semibold)
                                .padding(.top,4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    
                }
                Section("Geral") {
                    HStack {
                        SettingsRowView(imageName: "gear",
                                        title: "Version",
                                        tintColor: Color(.systemGray))
                        
                        Spacer()
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                Section("Conta") {
                    Button {
                        authAdapter.signOut()                        
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill",
                                        title: "Sair da conta",
                                        tintColor: Color(.red))
                    }
                    Button {
                        Task {
                            try await authAdapter.deleteUser()
                        }
                        
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill",
                                        title: "Deletar conta",
                                        tintColor: Color(.red))
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthAdapter())
    }
}
