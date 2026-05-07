import SwiftUI

struct FacadeTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            LeaguesView()
                .tabItem {
                    Image(systemName: "trophy.fill")
                    Text("Leagues")
                }

            MatchesView()
                .tabItem {
                    Image(systemName: "sportscourt.fill")
                    Text("Matches")
                }

            FavoritesView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .tint(GB.accent)
    }
}
