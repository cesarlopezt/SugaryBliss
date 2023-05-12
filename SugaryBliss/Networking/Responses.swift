//
//  Responses.swift
//  SugaryBliss
//
//  Created by Cesar Lopez on 5/12/23.
//

import Foundation

struct MealsListResponse: Codable {
    let meals: [Meal]
}

struct MealsDetailResponse: Codable {
    let meals: [MealDetail]?
}
