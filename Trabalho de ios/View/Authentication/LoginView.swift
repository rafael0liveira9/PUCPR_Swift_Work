//
//  LoginView.swift
//  Trabalho de ios
//
//  Created by user240648 on 2/26/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authAdapter: AuthAdapter
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo-salao")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .padding(.vertical, 20)
                
                VStack(spacing: 24) {
                    InputLoginView(text: $email, title: "E-mail", placeholder: "Digite seu e-mail...")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    InputLoginView(text: $password, title: "Senha", placeholder: "Digite sua senha...",
                    isSecureFirled: true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                }.padding(.horizontal)
                
                Button {
                    Task {
                        try await authAdapter.signIn(
                            withEmail: email,
                            password: password)
                    }
                } label: {
                    HStack {
                        Text("ENTRAR")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10))
                .padding(.top, 26)
                
                Spacer()
                
                NavigationLink {
                    RegisterView()
                } label: {
                    HStack (spacing: 4) {
                        Text("Nao possui Cadastro? ")
                        Text("Clique aqui")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && email.contains(".")
        && !password.isEmpty
        && password.count > 5
    }
}


#Preview {
    LoginView()
}
