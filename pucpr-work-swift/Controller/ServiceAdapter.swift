//
//  ServiceAdapter.swift
//  pucpr-work-swift
//
//  Created by Rafael Oliveira on 07/03/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


@MainActor

class ServiceAdapter: ObservableObject {

    func getData() async throws -> [Service] {
        var services: [Service] = []

        do {
            let querySnapshot = try await Firestore.firestore().collection("services").getDocuments()
            
            for document in querySnapshot.documents {
                if let service = try? document.data(as: Service.self) {
                    services.append(service)
                }
            }
        } catch {
            print("ERROR: Falha ao obter dados do serviço \(error.localizedDescription)")
            throw error
        }

        return services
    }
}
