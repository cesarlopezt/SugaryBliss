//
//  DessertsListView.swift
//  SugaryBliss
//
//  Created by Cesar Lopez on 5/11/23.
//

import SwiftUI

struct DessertsListView: View {
    @State var desserts: [Meal] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(desserts, id: \.idMeal) { dessert in
                    NavigationLink {
                        DessertDetailView(mealId: dessert.idMeal)
                    } label: {
                        Text(dessert.strMeal)
                    }

                }
            }
            .task {
                desserts = await fetchDesserts() ?? []
            }
            .navigationTitle("Desserts")
        }
    }
    
    func fetchDesserts() async -> [Meal]? {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decodedMeals = try JSONDecoder().decode(MealsListResponse.self, from: data)
            return decodedMeals.meals
            
        } catch {
            return nil
        }
    }
}

struct DessertsListView_Previews: PreviewProvider {
    static var previews: some View {
        DessertsListView()
    }
}
