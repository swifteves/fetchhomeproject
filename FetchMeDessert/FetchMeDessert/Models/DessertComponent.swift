//
//  DesertComponent.swift
//  FetchMeDessert
//
//  Created by Adrian Eves on 3/12/24.
//

import Foundation

struct DessertComponent: Codable {
    var strMeal: String?
    var strMealThumb: String?
    var idMeal: String?
}

struct MealListContainer: Decodable {
    var meals: [DessertComponent]
}
