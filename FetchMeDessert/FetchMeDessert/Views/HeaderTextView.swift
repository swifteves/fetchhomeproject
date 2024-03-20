//
//  HeaderTextView.swift
//  FetchMeDessert
//
//  Created by Adrian Eves on 3/19/24.
//

import SwiftUI

struct HeaderTextView: View {
    var text: String
    var body: some View {
        HStack {
            Text(text.uppercased())
                .foregroundStyle(.gray)
                .font(.footnote)
                .padding([.leading])
            .padding([.top, .bottom], 7)
            
            Spacer()
        }
    }
}

#Preview {
    HeaderTextView(text: "header")
}
