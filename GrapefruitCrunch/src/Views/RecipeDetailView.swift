import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(recipe.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)

                Text(recipe.instructions)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .padding()
        }
        .navigationTitle(recipe.title)
    }
}
