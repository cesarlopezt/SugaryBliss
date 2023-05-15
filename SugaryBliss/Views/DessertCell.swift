//
//  DessertCell.swift
//  SugaryBliss
//
//  Created by Cesar Lopez on 5/15/23.
//

import SwiftUI

struct DessertCell: View {
    var dessert: Meal
    private let imageWidth = 110.0

    var body: some View {
        HStack {
            CacheAsyncImage(url: URL(string: dessert.strMealThumb)!) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imageWidth)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                case .failure(let error):
                    let _ = print(error)
                    Text("Error")
                        .frame(width: imageWidth, height: imageWidth)
                case .empty:
                    ProgressView()
                        .frame(width: imageWidth, height: imageWidth)
                @unknown default:
                    Image(systemName: "questionmark")
                }
            }
            Text(dessert.strMeal)
        }
    }
}

struct DessertCell_Previews: PreviewProvider {
    static var previews: some View {
        DessertCell(dessert: Meal(
            strMeal: "Apam balik",
            strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
            idMeal: "53049"
        ))
    }
}
