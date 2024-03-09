//
//  FloatHomeView.swift
//  pucpr-work-swift
//
//  Created by Rafael Oliveira on 07/03/24.
//

import SwiftUI

struct FloatHomeView: View {
    @State private var activeView: String? = nil
    
    let initPath: String
    
    var body: some View {
            HStack(spacing: 15) {
                Spacer()
                
                NavigationLink(
                    destination: HomeView(),
                    tag: "Home",
                    selection: $activeView
                ) {
                    Button(action: {
                        if (activeView != "Home") {
                            activeView = "Home"
                        }
                    }) {
                        HStack {
                            Image(systemName: "house.fill")
                                .font(.system(size: 22))
                                .padding(7)
                                .foregroundColor(initPath != "Home" ? Color(.systemGray) : Color(UIColor.rosaescuro))
                                .background(initPath != "Home" ? Color(UIColor.rosaclaro) : .white)
                                .clipShape(Circle())
                                .shadow(color: .black, radius: 3, x: 0, y: 2)
                            
                            if (initPath == "Home") {
                                Text("Home")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.white))
                            }
                        }
                    }
                }
                
                if (initPath == "Home") {
                    Spacer()
                }
                
                NavigationLink(
                    destination: ServicesView(),
                    tag: "Serviços",
                    selection: $activeView
                ) {
                    Button(action: {
                        if (activeView != "Serviços") {
                            activeView = "Serviços"
                        }
                    }) {
                        HStack {
                            Image(systemName: "scissors")
                                .font(.system(size: 22))
                                .padding(7)
                                .foregroundColor(initPath != "Serviços" ? Color(.systemGray) : Color(UIColor.rosaescuro))
                                .background(initPath != "Serviços" ? Color(UIColor.rosaclaro) : .white)
                                .clipShape(Circle())
                                .shadow(color: .black, radius: 3, x: 0, y: 2)
                            
                            if (initPath == "Serviços") {
                                Text("Serviços")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.white))
                            }
                        }
                    }
                }
                
                if (initPath == "Serviços") {
                    Spacer()
                }
                
                NavigationLink(
                    destination: ProfileView(),
                    tag: "Perfil",
                    selection: $activeView
                ) {
                    Button(action: {
                        if (activeView != "Perfil") {
                            activeView = "Perfil"
                        }
                    }) {
                        HStack {
                            Image(systemName: "person.fill")
                                .font(.system(size: 22))
                                .padding(7)
                                .foregroundColor(initPath != "Perfil" ? Color(.systemGray) : Color(UIColor.rosaescuro))
                                .background(initPath != "Perfil" ? Color(UIColor.rosaclaro) : .white)
                                .clipShape(Circle())
                                .shadow(color: .black, radius: 3, x: 0, y: 2)
                            
                            if (initPath == "Perfil") {
                                Text("Perfil")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.white))
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.vertical, 10)
            .background(Color(UIColor.rosaescuro))
            .cornerRadius(30)
            .shadow(color: .black, radius: 3, x: 0, y: 2)
        }
    
    }

struct FloatHomeView_Previews: PreviewProvider {
    static var previews: some View {
        FloatHomeView(initPath: "Serviços")
    }
}
