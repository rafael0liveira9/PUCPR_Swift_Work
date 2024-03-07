//
//  RegisterView.swift
//  Trabalho de ios
//
//  Created by user240648 on 2/26/24.
//

import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authAdapter: AuthAdapter
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo-salao")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 160)
                    .padding(.vertical, 10)
                
                
                VStack(spacing: 12) {
                    InputLoginView(text: $name, title: "Nome Completo", placeholder: "Digite seu nome...")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    InputLoginView(text: $email, title: "E-mail", placeholder: "Digite seu e-mail...")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    InputLoginView(text: $password, title: "Senha", placeholder: "Digite sua senha...",
                    isSecureFirled: true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    ZStack(alignment: .trailing) {
                        InputLoginView(text: $confirmPassword,
                                       title: "Confirmar Senha",
                                       placeholder: "Confirme sua senha...",
                                       isSecureFirled: true)
                        
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            if password == confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            }else{
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button {
                    Task {
                        try await authAdapter.signUp(
                            withEmail: email,
                            password:password,
                            name:name)
                    }
                } label: {
                    HStack {
                        Text("CADASTRAR")
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
                .padding(.top, 30)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    HStack (spacing: 4) {
                        Text("Ja possui Cadastro? ")
                        Text("Faça Login")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

extension RegisterView: AuthenticationFormProtocol {
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && email.contains(".")
        && !password.isEmpty
        && password.count > 5
        && !name.isEmpty
        && name.count > 3
        && confirmPassword == password
    }
}

#Preview {
    LoginView()
}
