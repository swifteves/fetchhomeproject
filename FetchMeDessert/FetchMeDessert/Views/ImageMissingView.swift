//
//  ImageMissingView.swift
//  FetchMeDessert
//
//  Created by Adrian Eves on 3/13/24.
//

import SwiftUI

struct ImageMissingView: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.gray)
            Image(systemName: "person.slash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(50)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ImageMissingView()
}
