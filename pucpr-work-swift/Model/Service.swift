//
//  Service.swift
//  pucpr-work-swift
//
//  Created by Rafael Oliveira on 07/03/24.
//

import Foundation

struct Service: Identifiable, Codable {
    var id: Int
    var value: String
    var image: String
    var name: String
    var description: String
}
