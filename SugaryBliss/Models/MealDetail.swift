//
//  MealDetail.swift
//  SugaryBliss
//
//  Created by Cesar Lopez on 5/12/23.
//

import Foundation

struct Ingredient: Codable, Identifiable {
    var id = UUID()
    let name: String
    let measure: String
}

struct MealDetail {
    var idMeal: String
    var strMeal: String
    var strDrinkAlternate: String?
    var strCategory: String?
    var strArea: String?
    var strInstructions: String?
    var strMealThumb: String
    var strTags: String?
    var strYoutube: String?
    var ingredients: [Ingredient]
    var strSource: String?
    var strImageSource: String?
    var strCreativeCommonsConfirmed: String?
    var dateModified: String?
}

extension MealDetail: Codable {
    private enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strDrinkAlternate, strCategory, strArea,
             strInstructions, strMealThumb, strTags, strYoutube, strSource,
             strImageSource, strCreativeCommonsConfirmed, dateModified
        case ingredients
    }
    
    enum IngredientKeys: String, CodingKey {
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4,
             strIngredient5, strIngredient6, strIngredient7, strIngredient8,
             strIngredient9, strIngredient10, strIngredient11, strIngredient12,
             strIngredient13, strIngredient14, strIngredient15, strIngredient16,
             strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
             strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
             strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
             strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.idMeal = try container.decode(String.self, forKey: .idMeal)
        self.strMeal = try container.decode(String.self, forKey: .strMeal)
        self.strDrinkAlternate = try container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        self.strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
        self.strArea = try container.decodeIfPresent(String.self, forKey: .strArea)
        self.strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        self.strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        self.strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        self.strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)
        if let strYoutube {
            let youtubeURLComponents = URLComponents(string: strYoutube)
            let videoId = youtubeURLComponents?.queryItems?.first(where: {
                $0.name == "v"
            })?.value
            self.strYoutube = videoId
        }
        self.strSource = try container.decodeIfPresent(String.self, forKey: .strSource)
        self.strImageSource = try container.decodeIfPresent(String.self, forKey: .strImageSource)
        self.strCreativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: .strCreativeCommonsConfirmed)
        self.dateModified = try container.decodeIfPresent(String.self, forKey: .dateModified)

        let ingredientKeysContainer = try decoder.container(keyedBy: IngredientKeys.self)
        self.ingredients = []
        for i in 1...20 {
            let ingredientKey = "strIngredient\(i)"
            let measureKey = "strMeasure\(i)"
            
            let name = try ingredientKeysContainer.decodeIfPresent(String.self, forKey: IngredientKeys(stringValue: ingredientKey)!)
            let measure = try ingredientKeysContainer.decodeIfPresent(String.self, forKey: IngredientKeys(stringValue: measureKey)!)
            
            guard let name, !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                continue
            }
            guard let measure, !measure.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                continue
            }
            self.ingredients.append(.init(name: name, measure: measure))
        }
    }
}
