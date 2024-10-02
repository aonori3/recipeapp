import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: String
    @State private var featuredRecipe: Recipe?
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Welcome to Recipe Generator")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.top, 20)
                
                Text("What would you like to cook today?")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.gray)
                
            .padding()
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
    }
    }
}
