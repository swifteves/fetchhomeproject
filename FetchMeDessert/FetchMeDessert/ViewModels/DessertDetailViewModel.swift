//
//  DesertDetailViewModel.swift
//  FetchMeDessert
//
//  Created by Adrian Eves on 3/12/24.
//

import Foundation
import SwiftUI
import Observation

@Observable
class DessertDetailViewModel {
    // Keep track of detail state
    var idMeal: String?
    var loadingState = DetailStates.loading
    var errorMessage = ""
    var imageUrlString: String
    
    var ingredients = [String]()
    
    var measurements = [String]()
    
    init(id: String, imageUrlString: String) {
        self.idMeal = id
        self.imageUrlString = imageUrlString
    }
    
    var dessert: Meal?
    
    func fetchMeal() async {
        guard let id = idMeal, let url = URL.invokeDetailUrl(id: id) else {
            // Set detailed state to failed.
            loadingState = .failed
            return
        }
        
        do {
            let dessertResult = try await URLSession.shared.decode(MealContainer.self, from: url)
            let selectedDesert = dessertResult.meals[0]
            let descriptorsExist = selectedDesert.strMeal != "" && selectedDesert.strInstructions != ""
            let amountsExist = selectedDesert.strIngredient1 != "" && selectedDesert.strMeasure1 != ""
            if descriptorsExist && amountsExist {
                // Show the result
                dessert = selectedDesert
                // Configure ingredients
                configureIngredients()
                // Change state to loaded.
                loadingState = .loaded
            } else {
                // Change state to failed.
                loadingState = .failed
            }
        } catch let error {
            // Set detail state to failed
            loadingState = .failed
            errorMessage = error.localizedDescription
        }
    }
    
    private func getMeasurements() {
        let measureKeyString = "strMeasure"
        guard let measurementList = dessert?.getQuantities(propertyString: measureKeyString) else {
            fatalError("Unable to retrieve measurements.")
        }
        
        measurements = measurementList
    }
    
    private func getIngredients() {
        let ingredientKeyString = "strIngredient"
        guard let ingredientList = dessert?.getQuantities(propertyString: ingredientKeyString) else {
            fatalError("Unable to retrieve ingredients.")
        }
        
        ingredients = ingredientList
    }
    
    private func configureIngredients() {
        getIngredients()
        getMeasurements()
    }
    
    private func setImageUrl() {
        
    }
}
