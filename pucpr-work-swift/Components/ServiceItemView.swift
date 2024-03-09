//
//  ServiceItemView.swift
//  pucpr-work-swift
//
//  Created by Rafael Oliveira on 07/03/24.
//

import SwiftUI

struct ServiceItemView: View {
    let value: String
    let image: String
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .frame(height: 0.5)
                    .background(Color(UIColor.green))
                
                Text(value)
                    .fontWeight(.semibold)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background(Color(UIColor.green))
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
                Spacer()
            }
            .offset(y: -10)
            .padding(.horizontal, 10)
            .padding(.bottom, 15)
            
        }
        .background(Color.white)
        .cornerRadius(15.0)
        .padding(10)
        .shadow(color: .black, radius: 3, x: 0, y: 2)
    }
    
}

#Preview {
    ServiceItemView(value: "R$ 350,00", image: "image-blur", title: "Lorem Ipsum", description:"Lorem Ipsum is simply dummy text of the printing and typesetting industry")
}
