//
//  DessertDetailView.swift
//  SugaryBliss
//
//  Created by Cesar Lopez on 5/12/23.
//

import SwiftUI

struct DessertDetailView: View {
    @Environment(\.dismiss) var dismiss
    var mealId: String
    @State private var mealDetail: MealDetail? = nil
    @State private var isError = false
    
    
    var body: some View {
        Group {
            if let mealDetail {
                Form {
                    Section("Ingredients") {
                        IngredientsGrid(mealDetail: mealDetail)
                    }
                    Section("Instructions") {
                        Text(mealDetail.strInstructions ?? "")
                    }
                }
                .navigationTitle(mealDetail.strMeal)
                .navigationBarTitleDisplayMode(.inline)
            } else {
                VStack{}
                    .navigationTitle("Unable to load")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .task {
            mealDetail = await fetchDessert()
            isError = mealDetail == nil
        }
        .alert("Unable to load dessert", isPresented: $isError) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("There was a problem loading the details of this dessert.")
        }
    }
    
    func fetchDessert() async -> MealDetail? {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedMeals = try JSONDecoder().decode(MealsDetailResponse.self, from: data)
            return decodedMeals.meals?.first
            
        } catch {
            print("ERROR", error)
            return nil
        }
    }
}

struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DessertDetailView(mealId: "52862")
        }
    }
}
