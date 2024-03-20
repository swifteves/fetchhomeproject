//
//  DessertListCellView.swift
//  FetchMeDessert
//
//  Created by Adrian Eves on 3/13/24.
//

import SwiftUI

struct DessertListCellView: View {
    var name = "Dessert Name"
    var imageString = "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg"
    @State private var image: Image = Image(systemName: "pencil")
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: imageString),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 50, maxHeight: 50)
                        .mask(Circle())
                },
                placeholder: {
                    Circle()
                        .foregroundStyle(.gray)
                        .frame(maxWidth: 50, maxHeight: 50)
                }
            )
            Text(name)
                .font(.subheadline)
                .padding([.leading], 10)
            Spacer()
        }
        .padding([.leading], 10)
    }
}

#Preview {
    DessertListCellView()
}
