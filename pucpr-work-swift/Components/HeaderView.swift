//
//  HeaderView.swift
//  Trabalho de ios
//
//  Created by user240648 on 3/6/24.
//

import SwiftUI

struct HeaderView: View {
    let pageTitle: String

    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Text(pageTitle)
                    .fontWeight(.semibold)
                    .font(.system(size: 22))
                    .padding(.top, 4)
                    .foregroundColor(.black)
                    .padding(.trailing, 95)
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 20)
                    .foregroundColor(.black)
            }
            .frame(height: 70)
            .padding(.top, 15)
            
            
            Spacer()
        }
        .frame(height: 130)
        .background(Color(UIColor.rosaclaro))
    }
}

#if DEBUG
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(pageTitle: "HOME")
    }
}
#endif
