//
//  InputLoginView.swift
//  Trabalho de ios
//
//  Created by user240648 on 2/26/24.
//

import SwiftUI

struct InputLoginView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureFirled = false
    var body: some View {
        VStack (alignment: .leading, spacing: 12){
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if (isSecureFirled) {
                SecureField(placeholder, text:$text).font(.system(size: 14))
            }else {
                TextField(placeholder, text:$text).font(.system(size: 14))            }
        }
        Divider()
    }
}

#Preview {
    InputLoginView(text: .constant(""), title: "Digite o E-mail", placeholder: "nome@exemplo.com")
}
