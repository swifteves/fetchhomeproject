//
//  IngredientView.swift
//  FetchMeDessert
//
//  Created by Adrian Eves on 3/19/24.
//

import SwiftUI

struct IngredientView: View {
    var quantity: String
    var description: String
    
    var body: some View {
        HStack {
            HStack() {
                Text(quantity)
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .bold()
                Text(description)
                    .font(.subheadline)
            }
            .padding([.leading])
            .padding([.bottom], 3)
            
            Spacer()
        }
        .accessibilityLabel(Text("\(quantity) quantity of \(description)"))
    }
}

#Preview {
    IngredientView(quantity: "3/4", description: "grams")
}
