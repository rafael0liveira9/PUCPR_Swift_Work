//
//  Schedule.swift
//  pucpr-work-swift
//
//  Created by Rafael Oliveira on 08/03/24.
//

import Foundation
import FirebaseFirestoreSwift

struct Schedule: Identifiable, Codable {
    var id: Date
    var clientEmail: String
    var date: Date
    var professional: String
    var serviceName: String
    var serviceDescription: String
    var serviceValue: String
    var serviceImage: String
}
