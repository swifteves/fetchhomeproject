//
//  DessertDetailView.swift
//  FetchMeDessert
//
//  Created by Adrian Eves on 3/12/24.
//

import SwiftUI

struct DessertDetailView: View {
    @State var viewModel: DessertDetailViewModel
    let title: String
    let imageUrlString: String
    
    init(id: String, title: String, imageUrlString: String) {
        _viewModel = State(initialValue: DessertDetailViewModel(id: id, imageUrlString: imageUrlString))
        self.title = title
        self.imageUrlString = imageUrlString
    }
    
    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading:
                LoadingView()
            case .failed:
                Text("There was an error loading this content")
            case .loaded:
                NavigationView {
                    ScrollView {
                        VStack {
                            Group {
                                AsyncImage(
                                    url: URL(string: imageUrlString),
                                    content: { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 300, maxHeight: 300)
                                            .mask(RoundedRectangle(cornerRadius: 10, style: .circular)
                                                .frame(maxWidth: 300, maxHeight: 300))
                                    },
                                    placeholder: {
                                        RoundedRectangle(cornerRadius: 10, style: .circular)
                                            .foregroundStyle(.gray)
                                            .frame(maxWidth: 300, maxHeight: 300)
                                    }
                                )
                            }
                            // This is purely decorative. Screen readers can ignore it.
                            .accessibilityElement(children: .ignore)
                            
                            HeaderTextView(text: "ingredients")
                                .accessibilityElement()
                            ForEach(viewModel.ingredients.indices, id: \.self) { index in
                                IngredientView(quantity: viewModel.measurements[index], description: viewModel.ingredients[index])
                            }
                            
                            Spacer(minLength: 20)
                            
                            Group {
                                HeaderTextView(text: "instructions")
                                Text((viewModel.dessert?.strInstructions) ?? "instructions")
                                    .font(.subheadline)
                                    .padding([.leading, .trailing, .bottom])
                            }
                            .accessibilityElement(children: .combine)
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text(title)
                                    .bold()
                            }
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.fetchMeal()
        }
    }
}

#Preview {
    DessertDetailView(id: "52768", title: "Beethoven Day", imageUrlString: "whatever")
    // I was listening to the broadway recording of
    // "You're a Good Man, Charlie Brown" while working
    // on this :)
}
