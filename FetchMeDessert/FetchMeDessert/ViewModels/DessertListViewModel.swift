//
//  DesertListViewModel.swift
//  FetchMeDessert
//
//  Created by Adrian Eves on 3/12/24.
//

import Foundation
import SwiftUI
import Observation

@Observable
class DessertListViewModel {
    var loadingState = DetailStates.loading
    var errorMessage = ""
    var dessertList = [DessertComponent]()
    
    // Are you hungry? Let's get these desserts out here!
    func fetchDesserts() async {
        guard let dessertsUrl = URL.invokeDesserts() else {
            print("Error: The URL provided is invalid.")
            loadingState = .failed
            return
        }
        
        do {
            let dessertContainer = try await URLSession.shared.decode(MealListContainer.self, from: dessertsUrl)
            let dessertListResult = dessertContainer.meals
            guard let collectedList = filterDesserts(dessertListResult), !dessertListResult.isEmpty else {
                loadingState = .failed
                fatalError("Retrieved an empty list of desserts. Check to see that the correct URL is being used.")
            }
            
            dessertList = collectedList.sorted {
                // These are already guaranteed to have values
                // at this point in execution.
                $0.strMeal! < $1.strMeal!
            }
            
            print(dessertList)
        } catch let error {
            errorMessage = error.localizedDescription
            loadingState = .failed
        }
    }
    
    // Filter the desserts
    private func filterDesserts(_ desserts: [DessertComponent]) -> [DessertComponent]? {
        var collectedDesserts = [DessertComponent]()
        for dessert in desserts {
            guard let id = dessert.idMeal else {
                continue
            }
            
            guard let meal = dessert.strMeal else {
                continue
            }
            
            // We can proceed without a thumbnail because
            // visually impaired users do not depend on
            // this information. It can be categorised as
            // decorative imagery, which does not bar the
            // user from using the app for its intended
            // purpose.
            collectedDesserts.append(dessert)
        }
        
        if !collectedDesserts.isEmpty {
            return collectedDesserts
        }
        
        return nil
    }
}
