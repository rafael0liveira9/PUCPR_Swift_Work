//
//  User.swift
//  Trabalho de ios
//
//  Created by user240648 on 2/28/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            return formatter.string(from:components)
        }
        return ""
    }
    
}

extension User {
    static var DEFAULT_USER = User(id: NSUUID().uuidString, name: "Rafael Oliveira", email: "rafaelmariano01234@hotmail.com")
}
