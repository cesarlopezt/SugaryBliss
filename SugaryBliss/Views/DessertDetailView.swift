//
//  DessertDetailView.swift
//  SugaryBliss
//
//  Created by Cesar Lopez on 5/12/23.
//

import SwiftUI

struct DessertDetailView: View {
    var meal: Meal
    @State private var result: Result<MealDetail, Error>?
    
    var body: some View {
        Group {
            switch result {
            case .success(let mealDetail):
                Form {
                    if let videoId = mealDetail.strYoutube {         
                        Section ("Video") {
                            VideoView(videoId: videoId)
                                .frame(height: 200)
                        }
                    }
                    Section("Ingredients") {
                        IngredientsGrid(mealDetail: mealDetail)
                    }
                    Section("Instructions") {
                        Text(mealDetail.strInstructions ?? "")
                    }
                }
            case .failure(let error):
                let _ = print(error)
                Text("Error")
            case nil:
                ProgressView()
                    .task {
                        await MealLoader.shared.loadDessert(with: meal.idMeal) {
                            result = $0
                        }
                    }
            }
        }
        .navigationTitle(meal.strMeal)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DessertDetailView(meal: .init(
                strMeal: "Peach & Blueberry Grunt",
                strMealThumb: "https://www.themealdb.com/images/media/meals/ssxvup1511387476.jpg",
                idMeal: "52862")
            )
        }
    }
}
