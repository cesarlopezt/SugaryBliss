//
//  IngredientsGrid.swift
//  SugaryBliss
//
//  Created by Cesar Lopez on 5/14/23.
//

import SwiftUI

struct IngredientsGrid: View {
    let ingredientColumns = [GridItem(.flexible()), GridItem(.flexible())]
    var mealDetail: MealDetail
    
    var body: some View {
        LazyVGrid(columns: ingredientColumns, alignment: .leading, spacing: 5) {
            Group {
                Text("Ingredient").bold()
                Text("Measure").bold()
            }
            .opacity(0.4)
            ForEach(mealDetail.ingredients) { ingredient in
                Text(ingredient.name)
                Text(ingredient.measure)
            }
        }
        .padding(.vertical, 5)
    }
}

struct IngredientsGrid_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsGrid(
            mealDetail: MealDetail(
                idMeal: "12",
                strMeal: "Battenberg Cake",
                strMealThumb: "",
                ingredients: [
                    .init(name: "Plain Flour", measure: "120g"),
                    .init(name: "Cinnamon", measure: "1/4 teaspoon"),
                    .init(name: "Ice Cream", measure: "1 scoop")
                ]
        )
    )
    }
}
