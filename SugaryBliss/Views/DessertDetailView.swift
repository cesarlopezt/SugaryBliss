//
//  DessertDetailView.swift
//  SugaryBliss
//
//  Created by Cesar Lopez on 5/12/23.
//

import SwiftUI

struct DessertDetailView: View {
    var mealId: String
    @State private var mealDetail: MealDetail? = nil
    
    var body: some View {
        Text(mealDetail?.strMeal ?? "Gii")
            .task {
                mealDetail = await fetchDessert()
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
        DessertDetailView(mealId: "52862")
    }
}
