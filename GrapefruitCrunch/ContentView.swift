import SwiftUI

struct ContentView: View {
    @StateObject var pastRecipesManager = PastRecipesManager()
    @State private var selectedTab = "Home"
    @Binding var userIsLoggedIn: Bool

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeView(selectedTab: $selectedTab)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarItems(leading:
                        Button(action: {
                            // Add menu action here
                        }) {
                            Image(systemName: "line.horizontal.3")
                        }
                    )
            }
            .tabItem {
                Image(systemName: "house.fill")
            }
            .tag("Home")

            NavigationView {
                NewRecipeView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
            }
            .tag("NewRecipe")

            NavigationView {
                PastRecipesView()
            }
            .tabItem {
                Image(systemName: "bookmark")
            }
            .tag("PastRecipes")

            NavigationView {
                ProfileView(userIsLoggedIn: $userIsLoggedIn)
            }
            .tabItem {
                Image(systemName: "person.circle")
            }
            .tag("Profile")
        }
        .accentColor(.primaryColor)
        .environmentObject(pastRecipesManager)
    }
}
