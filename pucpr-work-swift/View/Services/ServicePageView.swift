import SwiftUI
import Combine


struct ServicePageView: View {
    @EnvironmentObject var authAdapter: AuthAdapter
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var scheduleAdapter: ScheduleAdapter
    
    
    let service: Service?
    
    @State private var date = Date()
    @State private var professional = "Cleonice"
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        
        
        VStack {
            HeaderView(pageTitle: service?.name ?? "")

            HStack {
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: 180)
            .background(
                HStack {
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(
                    HStack {
                        Image(service?.image ?? "")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .edgesIgnoringSafeArea(.all)
                            .overlay(
                                Color.black.opacity(0.3)
                            )
                    }
                ).clipped()
            )

            HStack(spacing: 30) {
                Image("logo-salao")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .padding(.top, 20)

                VStack(alignment: .leading, spacing: 10){
                    Text(service?.description ?? "")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    HStack {
                        Rectangle()
                            .frame(height: 0.5)
                            .background(Color(UIColor.green))

                        Text(service?.value ?? "")
                            .fontWeight(.semibold)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 5)
                            .background(Color(UIColor.green))
                            .cornerRadius(5)
                            .offset(y: -10)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
            .background(Color.white)
            .padding(10)

            ScrollView {
                VStack {
                    HStack {
                        Text("Agendamento")
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                            .padding(.horizontal, 10)
                            .background(Color(#colorLiteral(red: 1.0, green: 0.85, blue: 0.85, alpha: 1.0)))
                            .cornerRadius(5)
                            .offset(y: 10)
                        
                        Rectangle()
                            .frame(height: 0.5)
                            .background(Color.black)
                        
                        
                    }.padding(.horizontal, 20)
                    
                    HStack {
                        Text("Profissional")
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        Picker("| Prof:",
                               selection: $professional) {
                            Text("Cleonice").tag("Cleonice")
                            Text("Priscila").tag("Priscila")
                        }
                    }.padding(20)
                    
                    VStack {
                            DatePicker("Data e Horario:", selection: $date, in: Date()...)
                    }.padding(.bottom, 20)
                    
                    
                    Button {
                        print(authAdapter.currentUser?.email ?? "", service?.id ?? 0, professional, date)
                        Task {
                            try await scheduleAdapter.createSchedule(
                                clientEmail: authAdapter.currentUser?.email ?? "",
                                professional: professional,
                                date: date,
                                serviceName: service!.name,
                                serviceDescription: service!.description,
                                serviceValue: service!.value,
                                serviceImage: service!.image
                            )
                        }
                    } label: {
                        HStack {
                            Text("SALVAR")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    }
                    .background(Color(.systemBlue)
                    .cornerRadius(10))
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding(.horizontal,20)
                .padding(.horizontal,30)
            }
            .background(Color.white)
            .cornerRadius(15.0)
            .padding(.horizontal,30)
            
        }
        .background(Color(UIColor.backgroundGray))
        .onAppear {
            cancellable = scheduleAdapter.$shouldNavigateToHome.sink { shouldNavigate in
                if shouldNavigate {
                    print("Navigating to HomeView")
                    presentationMode.wrappedValue.dismiss()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }

    }
    
}


struct ServicePageView_Previews: PreviewProvider {
    static var previews: some View {
        ServicePageView(service: Service(id: 1, value: "R$ 150,00", image: "corte-cabelo", name: "Corte de Cabelo", description: "jaskdajsd dhasidhas shidbiasd siausbdiuasd sadiuhasid asdias icas"))
    }
}
