import SwiftUI

struct LeaguesView: View {
    @EnvironmentObject var store: SportsStore

    var body: some View {
        NavigationStack {
            List {
                ForEach(SportsAPI.leagues, id: \.id) { league in
                    NavigationLink(value: league.id) {
                        LeagueAPIRow(league: league, count: store.teamCount(for: league.id))
                    }
                    .listRowBackground(GB.card)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(GB.bg.ignoresSafeArea())
            .navigationTitle("Leagues")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationDestination(for: String.self) { id in
                if let info = SportsAPI.leagues.first(where: { $0.id == id }) {
                    LiveStandingsView(leagueId: info.id, leagueName: info.name)
                        .environmentObject(store)
                }
            }
        }
    }
}

struct LeagueAPIRow: View {
    let league: SportsAPI.LeagueInfo
    let count: Int

    var body: some View {
        HStack(spacing: 14) {
            RemoteBadge(url: league.badge, size: 48)

            VStack(alignment: .leading, spacing: 4) {
                Text(league.name)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(GB.text)
                HStack(spacing: 6) {
                    Text("Season \(league.season)")
                        .font(.system(size: 12))
                        .foregroundStyle(GB.textSecondary)
                    if count > 0 {
                        Text("·")
                            .foregroundStyle(GB.textMuted)
                        Text("\(count) teams")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(GB.accent)
                    }
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(GB.textMuted)
        }
        .padding(.vertical, 6)
    }
}
