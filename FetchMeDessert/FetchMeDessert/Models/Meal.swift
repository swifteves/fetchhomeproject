//
//  Meal.swift
//  FetchMeDessert
//
//  Created by Adrian Eves on 3/12/24.
//

import Foundation

struct Meal: Codable {
    var idMeal: String?
    var strMeal: String?
    var strDrinkAlternate: String?
    var strCategory: String?
    var strArea: String?
    var strInstructions: String?
    var strMealThumb: String?
    var strTags: String?
    var strYoutube: String?
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strIngredient16: String?
    var strIngredient17: String?
    var strIngredient18: String?
    var strIngredient19: String?
    var strIngredient20: String?
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var strMeasure16: String?
    var strMeasure17: String?
    var strMeasure18: String?
    var strMeasure19: String?
    var strMeasure20: String?
    var strSource: String?
    var strImageSource: String?
    var strCreativeCommonsConfirmed: String?
    var dateModified: String?
}

struct MealContainer: Decodable {
    var meals: [Meal]
}

extension Meal: PropertyLoopable {
    func allProperties() throws -> [String : Any]? {
        var result: [String: Any] = [:]
        let mirror = Mirror(reflecting: self)
        
        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            return nil
        }
        
        for (laybeMaybe, valueMaybe) in mirror.children {
            guard let label = laybeMaybe else {
                continue
            }
            
            result[label] = valueMaybe
        }
        
        return result
    }
    
    func getQuantities(propertyString: String) -> [String] {
        guard let properties = try? allProperties() else {
            fatalError("Could not retrieve meal properties.")
        }
        
        var orderedInstructions = [String](repeating: "", count: 20)
        
        for (indicator, description) in properties {
            if indicator.contains(propertyString) {
                // Trim off strMeasure string
                // insert item at number - 1
                let prefixLength = propertyString.count
                guard let value = Int(indicator.dropFirst(prefixLength)) else {
                    fatalError("There was a problem getting a number from the instruction you're using.")
                }
                
                let descriptionString = description as? String
                orderedInstructions[value - 1] = "\(descriptionString ?? "")"
            }
        }
        
        return orderedInstructions.filter {
            $0 != ""
        }
    }
}

protocol PropertyLoopable {
    func allProperties() throws -> [String:Any]?
}
