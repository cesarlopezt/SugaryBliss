//
//  MealLoader.swift
//  SugaryBliss
//
//  Created by Cesar Lopez on 5/14/23.
//

import Foundation

class MealLoader {
    enum MealLoaderError: Error {
        case invalidURL
        case mealNotFound
    }
    
    private let urlSession = URLSession.shared
    
    func loadDesserts(completionHandler: @escaping (Result<[Meal], Error>) -> Void) async {
        do {
            guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
                throw MealLoaderError.invalidURL
            }
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"

            let (data, _) = try await urlSession.data(for: request)
            let decodedMeals = try JSONDecoder().decode(MealsListResponse.self, from: data)
            completionHandler(.success(decodedMeals.meals))
        } catch {
            completionHandler(.failure(error))
        }
    }
    
    func loadDessert(with id: String, completionHandler: @escaping (Result<MealDetail, Error>) -> Void) async {
        do {
            guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
                throw MealLoaderError.invalidURL
            }
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedMeals = try JSONDecoder().decode(MealsDetailResponse.self, from: data)
            guard let meal = decodedMeals.meals?.first else {
                throw MealLoaderError.mealNotFound
            }
            completionHandler(.success(meal))
        } catch {
            completionHandler(.failure(error))
        }
    }
}
