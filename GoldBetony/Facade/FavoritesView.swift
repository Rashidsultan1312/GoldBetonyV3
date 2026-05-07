import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var store: SportsStore
    @AppStorage("favorites") private var favData = Data()

    private var favoriteIds: Set<String> {
        (try? JSONDecoder().decode(Set<String>.self, from: favData)) ?? []
    }

    private var favoriteTeams: [APITeam] {
        var result: [APITeam] = []
        for (_, teams) in store.teams {
            result.append(contentsOf: teams.filter { favoriteIds.contains($0.idTeam) })
        }
        return result
    }

    var body: some View {
        NavigationStack {
            Group {
                if favoriteTeams.isEmpty {
                    emptyState
                } else {
                    teamsList
                }
            }
            .background(GB.bg.ignoresSafeArea())
            .navigationTitle("Favorites")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationDestination(for: APITeam.self) { team in
                if let leagueId = findLeagueId(for: team) {
                    APITeamDetailView(team: team, leagueId: leagueId)
                        .environmentObject(store)
                }
            }
        }
    }

    private func findLeagueId(for team: APITeam) -> String? {
        for (leagueId, teams) in store.teams {
            if teams.contains(where: { $0.idTeam == team.idTeam }) {
                return leagueId
            }
        }
        return "4328"
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "star")
                .font(.system(size: 52))
                .foregroundStyle(GB.textMuted)
            Text("No favorites yet")
                .font(.gbH2)
                .foregroundStyle(GB.textSecondary)
            Text("Tap the star icon on any team\nto add it to your favorites")
                .font(.gbBody)
                .foregroundStyle(GB.textMuted)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var teamsList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 10) {
                ForEach(favoriteTeams) { team in
                    NavigationLink(value: team) {
                        APITeamRow(team: team)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
    }
}
