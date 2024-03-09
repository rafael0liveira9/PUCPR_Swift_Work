//
//  HomeView.swift
//  Trabalho de ios
//
//  Created by user240648 on 3/6/24.
//

import SwiftUI



struct DeleteConfirmationView: View {
    @Binding var isPresented: Bool
    var onConfirm: () -> Void

    var body: some View {
        VStack {
            Text("Deseja deletar este agendamento?")
                .font(.headline)
                .padding()

            HStack {
                Button("Sim") {
                    onConfirm()
                    isPresented = false
                }
                .foregroundColor(.red)

                Spacer()

                Button("Não") {
                    isPresented = false
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
        .padding()
    }
}

struct InfoModalView: View {
    var schedule: Schedule?
    @Binding var isInfoModalVisible: Bool

    var body: some View {
        VStack {
            VStack (alignment: .leading){
                Text("Detalhes do Agendamento")
                    .font(.title)
                    .padding()
                
                // Aqui você pode exibir as informações específicas do agendamento
                if let schedule = schedule {

                    Text("Serviço: \(schedule.serviceName)")
                        .padding(.bottom, 10)
                    Text("Valor: \(schedule.serviceValue)")
                        .padding(.bottom, 10)
                    Text("Data: \(formatToDDMMYYY(from: schedule.date)) as \(formatToHHMM(from: schedule.date))")
                        .padding(.bottom, 10)
                    Text("Descrição: \(schedule.serviceDescription)")
                        .padding(.bottom, 10)
                }
                HStack{
                    Spacer()
                    Button("OK") {
                        isInfoModalVisible = false
                    }
                    Spacer()
                }
                .padding(.leading,20)
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

struct HomeView: View {
    @EnvironmentObject var authAdapter: AuthAdapter
    @EnvironmentObject var scheduleAdapter: ScheduleAdapter
    @State private var isDeleteConfirmationVisible = false
    @State private var isInfoModalVisible = false
    @State private var selectedSchedule: Schedule?
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(pageTitle: "Home")
                
                ZStack {
                    ScrollView {
                        VStack {
                            HStack {
                                Text("Agendamentos")
                                    .fontWeight(.semibold)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 10)
                                    .background(Color(#colorLiteral(red: 1.0, green: 0.85, blue: 0.85, alpha: 1.0)))
                                    .cornerRadius(5)
                                
                                Rectangle()
                                    .frame(height: 0.5)
                                    .background(Color.black)
                                
                                
                            }.padding(20)
                            if scheduleAdapter.schedules.isEmpty {
                                Text("Sem Agendamentos")
                                    .foregroundColor(.gray)
                                    .padding()
                            } else {
                                ForEach(scheduleAdapter.schedules) { schedule in
                                    ScheduleItemView(date: formatToDDMM(from: schedule.date),
                                                     image: schedule.serviceImage,
                                                     title: schedule.serviceName,
                                                     description: schedule.serviceDescription)
                                            .onTapGesture {
                                                selectedSchedule = schedule
                                                isInfoModalVisible = true
                                            }
                                            .onLongPressGesture {
                                                isDeleteConfirmationVisible.toggle()
                                            }
                                            .alert(isPresented: $isDeleteConfirmationVisible) {
                                            Alert(
                                                title: Text("Deseja deletar este agendamento?"),
                                                primaryButton: .destructive(Text("Sim")) {
                                                            if let whatsappURL = URL(string: "https://wa.me/5541992730204?text=Quero+cancelar+meu+agendamento...") {
                                                                UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                                                            }
                                                            isDeleteConfirmationVisible = false
                                                        },
                                                secondaryButton: .cancel(Text("Não")) {
                                                    isDeleteConfirmationVisible = false
                                                }
                                            )
                                        }.sheet(isPresented: $isInfoModalVisible) {
                                            InfoModalView(schedule: selectedSchedule, isInfoModalVisible: $isInfoModalVisible)
                                        }
                                    
                                }
                            }
                            Spacer()
                        }
                        .padding()
                        .frame(maxHeight: .infinity)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    
                    VStack {
                        Spacer()
                        FloatHomeView(initPath: "Home").padding(.horizontal, 20)
                    }
                }
            }
            .background(Color(UIColor.backgroundGray))
            .onAppear {
                if let currentEmail = authAdapter.currentUser?.email {
                    Task {
                        try? await scheduleAdapter.getScheduleData(email: currentEmail)
                    }
                }
            }
        }
        .navigationBarTitle("Home", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

func formatToDDMM(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM"
    return dateFormatter.string(from: date)
}

func formatToDDMMYYY(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/YYY"
    return dateFormatter.string(from: date)
}
func formatToHHMM(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:MM"
    return dateFormatter.string(from: date)
}
extension View {
    func onLongPressGesture(minimumDuration: Double = 1.0, perform action: @escaping () -> Void) -> some View {
        return self.gesture(
            LongPressGesture(minimumDuration: minimumDuration)
                .onEnded { _ in
                    action()
                }
        )
    }
}


#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let authAdapter = AuthAdapter()
        let scheduleAdapter = ScheduleAdapter()
        
        return HomeView()
            .environmentObject(authAdapter).environmentObject(scheduleAdapter)
        
    }
}
#endif

