//
//  ScheduleItemView.swift
//  Trabalho de ios
//
//  Created by user240648 on 3/6/24.
//

import SwiftUI

struct ScheduleItemView: View {
    let date: String
    let image: String
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .frame(height: 0.5)
                    .background(Color.black)
                
                Text(date)
                    .fontWeight(.semibold)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background(Color(#colorLiteral(red: 1.0, green: 0.85, blue: 0.85, alpha: 1.0)))
                    .cornerRadius(5)
                    .offset(y: 10)
            }.padding(.horizontal, 10)
            HStack {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .cornerRadius(5)
                VStack(alignment: .leading, spacing: 4){
                    Text(title)
                        .fontWeight(.semibold)
                        .padding(.top,4)
                    
                    Text(description)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }.offset(y: -10)
        }.padding(.bottom, 20)
    }
}

#Preview {
    ScheduleItemView(date: "DD/MM", image: "image-blur", title: "Lorem Ipsum", description:"Lorem Ipsum is simply dummy text of the printing and typesetting industry")
}
