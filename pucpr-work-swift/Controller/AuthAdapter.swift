//
//  AuthAdapter.swift
//  Trabalho de ios
//
//  Created by user240648 on 3/3/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI

protocol AuthenticationFormProtocol {
    var formIsValid: Bool{get}
}

@MainActor

class AuthAdapter: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        self.userSession = Auth.auth().currentUser
        Task {
            try? await getUserData()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await getUserData()
        }catch{
            print("ERROR: Falha fazer Login \(error.localizedDescription) ")
        }
    }
    
    func signUp(withEmail email: String, password: String, name: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, name: name, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            try await getUserData()
        } catch {
            print("ERROR: Falha ao criar este usuario \(error.localizedDescription) ")
        }
    }
    
    func signOut() {
        print("DEBUG: Chamando signOut")
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            
            LoginView()
        } catch {
            print("ERRO: Falha ao Fazer LogOff \(error.localizedDescription)")
        }
    }
    
    func deleteUser() async throws {
            do {
                let userId = self.userSession?.uid ?? ""
                try await Firestore.firestore().collection("users").document(userId).delete()
                try await Auth.auth().currentUser?.delete()
                

                self.userSession = nil
                self.currentUser = nil
            } catch {
                print("ERRO: Falha ao excluir o usuário \(error.localizedDescription)")
            }
        }
    
    func getUserData() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("INFO: User is \(String(describing: self.currentUser))")
    }
    

}
