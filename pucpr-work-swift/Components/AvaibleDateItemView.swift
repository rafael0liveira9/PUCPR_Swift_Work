//
//  AvaibleDateItemView.swift
//  pucpr-work-swift
//
//  Created by Rafael Oliveira on 07/03/24.
//

import SwiftUI

struct AvaibleDateItemView: View {
    let date: Date
    let professional: String
    
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .frame(height: 0.5)
                    .background(Color.black)
                
                Text(formattedDate(date))
                    .fontWeight(.semibold)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background(Color(#colorLiteral(red: 1.0, green: 0.85, blue: 0.85, alpha: 1.0)))
                    .cornerRadius(5)
                    .offset(y: 10)
            }.padding(.horizontal, 20)
            
            VStack (alignment: .leading, spacing: 5) {
                HStack{
                    Text("Profissional: ")
                        .fontWeight(.light)
                        .frame(width: 120, alignment: .leading)
                    Text(professional)
                        .fontWeight(.light)
                    
                    Spacer()
                }

                HStack{
                    Text("Horario: ")
                        .fontWeight(.light)
                        .padding(.horizontal, 10)
                        .frame(width: 120, alignment: .leading)
                    Text(formattedTime(date))
                        .fontWeight(.light)
                    
                    Spacer()
                }

                HStack{
                    Text("Data: ")
                        .fontWeight(.light)
                        .padding(.horizontal, 10)
                        .frame(width: 120, alignment: .leading)
                    Text(formattedFullDate(date))
                        .fontWeight(.light)
                    
                    Spacer()
                }
                
                
            }
            .frame(width: .infinity)
            .padding(20)
            .offset(y: -20)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(15.0)
    }
}

func formattedDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM"
    return dateFormatter.string(from: date)
}

func formattedFullDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/YYYY"
    return dateFormatter.string(from: date)
}

func formattedTime(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.string(from: date)
}

#Preview {
    AvaibleDateItemView(date: Date(), professional: "Cleonice")
}
