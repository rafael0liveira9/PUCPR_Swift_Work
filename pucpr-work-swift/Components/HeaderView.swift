//
//  HeaderView.swift
//  Trabalho de ios
//
//  Created by user240648 on 3/6/24.
//

import SwiftUI

struct HeaderView: View {
    @State private var isProfileViewActive: Bool = false
    let pageTitle: String

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(pageTitle)
                    .fontWeight(.semibold)
                    .font(.system(size: 22))
                    .padding(.top, 4)
                    .foregroundColor(.white)
                
                Spacer()
                
            }
            .frame(height: 70)
            .padding(.top, 15)

            Spacer()
        }
        .frame(height: 70)
        .background(Color(UIColor.rosaescuro))
        .shadow(color: .black, radius: 3, x: 0, y: 2)
    }
}

#if DEBUG
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(pageTitle: "HOME")
    }
}
#endif
