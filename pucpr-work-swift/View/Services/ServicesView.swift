//
//  ServicesView.swift
//  pucpr-work-swift
//
//  Created by Rafael Oliveira on 07/03/24.
//

import SwiftUI

struct ServicesView: View {
    @EnvironmentObject var authAdapter: AuthAdapter
    @StateObject private var serviceAdapter = ServiceAdapter()
    @State private var services: [Service] = []
    @State private var selectedService: Service? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(pageTitle: "Servicos")
                ZStack {
                    List {
                        ForEach(services, id: \.id) { service in
                            NavigationLink(
                                destination: ServicePageView(service: service),
                                label: {
                                    ServiceItemView(value: service.value,
                                                    image: service.image,
                                                    title: service.name,
                                                    description: service.description)
                                }
                            )
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    VStack {
                        
                        Spacer()
                        FloatHomeView(initPath: "Serviços").padding(.horizontal, 20)
                    }
                }
                .onAppear {
                    Task.init {
                        do {
                            services = try await serviceAdapter.getData()
                        } catch {
                            // Tratar erro, se necessário
                            print("Erro ao obter dados: \(error.localizedDescription)")
                        }
                    }
                }
                .background(Color(UIColor.systemBackground))
            }
        }
        .navigationBarTitle("Serviços", displayMode: .inline)
        .navigationBarHidden(true)
    }
}
    
#if DEBUG
struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        let authAdapter = AuthAdapter()
        return ServicesView()
            .environmentObject(authAdapter)
    }
}
#endif

