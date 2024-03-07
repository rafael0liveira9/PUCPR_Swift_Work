//
//  HomeView.swift
//  Trabalho de ios
//
//  Created by user240648 on 3/6/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HeaderView(pageTitle: "Home")
            
            ZStack {
                ScrollView {
                    VStack {
                        ScheduleItemView(date: "DD/MM", image: "image-blur", title: "Lorem Ipsum", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry")
                                                
                        Spacer()
                    }
                    .padding()
                    .padding(.top, 30)
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .frame(maxHeight: .infinity)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                .offset(y: -40)
                .frame(maxHeight: .infinity)
            }
            
        }.background(Color(UIColor.backgroundGray))
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif

