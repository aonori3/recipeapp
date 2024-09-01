//
//  RecipeService.swift
//  GrapefruitCrunch
//
//  Created by ashley mo on 8/29/24.
//
import Foundation

class RecipeNetworkManager {
    let apiKey = "API_KEY"
    let baseURL = "https://api.openai.com/v1/chat/completions"

    func generateRecipe(ingredients: [String], completion: @escaping (String?) -> Void) {
        let prompt = "Create a recipe using only the following ingredients: \(ingredients.joined(separator: ", ")). Provide a detailed recipe."

        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "You are a helpful assistant."],
                ["role": "user", "content": prompt]
            ],
            "max_tokens": 150
        ]

        guard let url = URL(string: baseURL) else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Failed to serialize JSON: \(error)")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let text = message["content"] as? String {
                    completion(text.trimmingCharacters(in: .whitespacesAndNewlines))
                } else {
                    print("Unexpected JSON structure")
                    completion(nil)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

struct Recipe: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var image: String?
    var ingredients: [String]  // Array of ingredients
    var instructions: String  // Recipe instructions
}
