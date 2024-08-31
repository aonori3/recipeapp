//
//  RecipeService.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//
import Foundation

class RecipeNetworkManager {
    let apiKey = "SPOONACULAR_API_KEY"
    let baseURL = "https://api.spoonacular.com/recipes/findByIngredients"

    func fetchRecipes(ingredients: [String], completion: @escaping ([Recipe]?) -> Void) {
        let ingredientsString = ingredients.joined(separator: ",")
        let urlString = "\(baseURL)?ingredients=\(ingredientsString)&number=10&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let recipes = try JSONDecoder().decode([Recipe].self, from: data)
                    completion(recipes)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }.resume()
    }
}

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String?
}
