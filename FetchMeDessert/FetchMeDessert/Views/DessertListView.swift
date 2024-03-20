//
//  ContentView.swift
//  FetchMeDessert
//
//  Created by Adrian Eves on 3/12/24.
//

import SwiftUI

struct DessertListView: View {
    @State private var viewModel = DessertListViewModel()
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.dessertList, id: \.idMeal) { dessert in
                    NavigationLink(destination: DessertDetailView(id: dessert.idMeal!, title: dessert.strMeal!, imageUrlString: dessert.strMealThumb!)) {
                        DessertListCellView(name: dessert.strMeal!, imageString: dessert.strMealThumb!)
                    }
                }
            }
            .task {
                await viewModel.fetchDesserts()
            }
            .navigationTitle("FetchMeDessert")
        }
    }
}

#Preview {
    DessertListView()
}
