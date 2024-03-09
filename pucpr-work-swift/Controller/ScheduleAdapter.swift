import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class ScheduleAdapter: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isScheduleCreated = false {
            didSet {
                if isScheduleCreated {
                    shouldNavigateToHome = true
                }
            }
        }
    @Published var shouldNavigateToHome = false
    @Published var schedules: [Schedule] = []


    func createSchedule(
        clientEmail: String,
        professional: String,
        date: Date,
        serviceName: String,
        serviceDescription: String,
        serviceValue: String,
        serviceImage: String
    ) async throws {
        do {
            var schedule = Schedule(
                id: Date(),
                clientEmail: clientEmail,
                date: date,
                professional: professional,
                serviceName: serviceName,
                serviceDescription: serviceDescription,
                serviceValue: serviceValue,
                serviceImage: serviceImage
            )

            let documentReference = try await Firestore.firestore().collection("schedule").addDocument(from: schedule)


            schedules.append(schedule)

            print("Document added successfully")

            isScheduleCreated = true
        } catch {
            print("ERROR: Falha ao criar este agendamento \(error.localizedDescription)")
        }
    }

    func deleteSchedule(id: Date) async throws {
        do {
            print("Deleting schedule with id: \(id)")

            // Convertendo o ID para um timestamp Unix para usar como identificador no Firestore
            let timestamp = id.timeIntervalSince1970

            try await Firestore.firestore().collection("schedule").document("\(timestamp)").delete()

            if let index = schedules.firstIndex(where: { $0.id == id }) {
                schedules.remove(at: index)
                print("Schedule removed from local array")
            }

            print("Schedule deleted successfully")
        } catch {
            print("ERROR: Falha ao excluir o agendamento \(error.localizedDescription)")
        }
    }


    func getScheduleData(email: String) async throws {
        do {
            let querySnapshot = try await Firestore.firestore()
                .collection("schedule")
                .whereField("clientEmail", isEqualTo: email)
                .getDocuments()

            print("Firebase Response: \(querySnapshot.documents)")

            schedules = try querySnapshot.documents.compactMap { document in
                guard let schedule = try? document.data(as: Schedule.self) else {

                    return nil
                }
                return schedule
            }

            print("Schedule data retrieved successfully")
        } catch {
            print("ERROR: Falha ao obter os dados do agendamento \(error.localizedDescription)")
        }
    }
}
