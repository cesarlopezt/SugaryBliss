//
//  DessertsListView.swift
//  SugaryBliss
//
//  Created by Cesar Lopez on 5/11/23.
//

import SwiftUI

struct DessertsListView: View {
    @State private var result: Result<[Meal], Error>?
    var loader = MealLoader()

    var body: some View {
        NavigationView {
            switch result {
            case .success(let desserts):
                List {
                    ForEach(desserts, id: \.idMeal) { dessert in
                        NavigationLink {
                            DessertDetailView(meal: dessert)
                        } label: {
                            DessertCell(dessert: dessert)
                        }
                    }
                }
                .navigationTitle("Desserts")
            case .failure(let error):
                let _ = print(error)
                Text("Error")
            case nil:
                ProgressView()
                    .task {
                        await loader.loadDesserts {
                            result = $0
                        }
                    }
            }
        }
    }
}

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

struct DessertsListView_Previews: PreviewProvider {
    static var previews: some View {
        DessertsListView()
    }
}
