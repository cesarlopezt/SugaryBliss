//
//  IngredientsGrid.swift
//  SugaryBliss
//
//  Created by Cesar Lopez on 5/14/23.
//

import SwiftUI

struct Ingredient: Identifiable {
    var id = UUID()
    var name: String
    var measurement: String
}

struct IngredientsGrid: View {
    let ingredientColumns = [GridItem(.flexible()), GridItem(.flexible())]
    var mealDetail: MealDetail
    var ingredients: [Ingredient]
    
    init(mealDetail: MealDetail) {
        self.mealDetail = mealDetail
        
        // Access to properties dinamically to build list of ingredients
        let mirrorMealDetail = Mirror(reflecting: mealDetail)

        self.ingredients = []
        for i in 1...20 {
            let ingredientLabel = "strIngredient\(i)"
            let measureLabel = "strMeasure\(i)"

            let ingredientName = mirrorMealDetail.children.first(where: { $0.label == ingredientLabel })?.value as? String
            guard let ingredientName, !ingredientName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                continue
            }
            let measure = mirrorMealDetail.children.first(where: { $0.label == measureLabel })?.value as? String
            guard let measure, !measure.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                continue
            }

            self.ingredients.append(.init(name: ingredientName, measurement: measure))
        }
        
    }

    var body: some View {
        LazyVGrid(columns: ingredientColumns, alignment: .leading, spacing: 10) {
            ForEach(ingredients) { ingredient in
                Text(ingredient.name)
                Text(ingredient.measurement)
            }
        }
        .padding(.vertical, 10)
    }
}

struct IngredientsGrid_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsGrid(mealDetail: MealDetail(idMeal: "12", strMeal: "Battenberg Cake", strMealThumb: ""))
    }
}
