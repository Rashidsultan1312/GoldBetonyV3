import SwiftUI

struct TeamDetailView: View {
    let team: Team
    @AppStorage("favorites") private var favData = Data()

    private var isFav: Bool { favorites.contains(team.id) }
    private var favorites: Set<String> {
        (try? JSONDecoder().decode(Set<String>.self, from: favData)) ?? []
    }
    private func toggleFav() {
        var set = favorites
        if set.contains(team.id) { set.remove(team.id) } else { set.insert(team.id) }
        favData = (try? JSONEncoder().encode(set)) ?? Data()
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                header
                statsGrid
                infoSection
                squadSection
            }
            .padding(.bottom, 20)
        }
        .background(GB.bg.ignoresSafeArea())
        .navigationTitle(team.shortName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: toggleFav) {
                Image(systemName: isFav ? "star.fill" : "star")
                    .foregroundStyle(GB.accent)
            }
        }
    }

    private var header: some View {
        ZStack {
            LinearGradient(
                colors: [team.color.opacity(0.4), GB.bg],
                startPoint: .top, endPoint: .bottom
            )
            .frame(height: 180)

            VStack(spacing: 12) {
                TeamLogoFromModel(team: team, size: 80)
                Text(team.name)
                    .font(.gbTitle)
                    .foregroundStyle(GB.text)
                HStack(spacing: 6) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(GB.accent)
                    Text(String(format: "%.1f", team.rating))
                        .fontWeight(.bold)
                        .foregroundStyle(GB.text)
                    Text("·")
                        .foregroundStyle(GB.textMuted)
                    Text(team.coach)
                        .foregroundStyle(GB.textSecondary)
                }
                .font(.system(size: 14))
            }
        }
    }

    private var statsGrid: some View {
        HStack(spacing: 0) {
            let totalGoals = team.players.reduce(0) { $0 + $1.stats.goals }
            let totalAssists = team.players.reduce(0) { $0 + $1.stats.assists }
            let avgRating = team.players.isEmpty ? 0 : team.players.reduce(0.0) { $0 + $1.stats.rating } / Double(team.players.count)

            statCell("Players", "\(team.players.count)")
            divider
            statCell("Goals", "\(totalGoals)")
            divider
            statCell("Assists", "\(totalAssists)")
            divider
            statCell("Avg Rating", String(format: "%.1f", avgRating))
        }
        .padding(.vertical, 16)
        .background(GB.card)
        .clipShape(RoundedRectangle(cornerRadius: GB.radius))
        .overlay(
            RoundedRectangle(cornerRadius: GB.radius)
                .stroke(GB.border, lineWidth: 0.5)
        )
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }

    private func statCell(_ label: String, _ value: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(GB.accent)
            Text(label)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(GB.textMuted)
        }
        .frame(maxWidth: .infinity)
    }

    private var divider: some View {
        Rectangle().fill(GB.border).frame(width: 0.5, height: 36)
    }

    private var infoSection: some View {
        VStack(spacing: 10) {
            infoRow("mappin.circle.fill", "City", team.city)
            infoRow("building.2.fill", "Stadium", "\(team.stadium) (\(team.capacity.formatted()))")
            infoRow("calendar", "Founded", "\(team.founded)")
            infoRow("flag.fill", "Country", team.country)
        }
        .padding(16)
        .background(GB.card)
        .clipShape(RoundedRectangle(cornerRadius: GB.radius))
        .overlay(
            RoundedRectangle(cornerRadius: GB.radius)
                .stroke(GB.border, lineWidth: 0.5)
        )
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }

    private func infoRow(_ icon: String, _ label: String, _ value: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundStyle(GB.purple)
                .frame(width: 20)
            Text(label)
                .font(.system(size: 13))
                .foregroundStyle(GB.textSecondary)
            Spacer()
            Text(value)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(GB.text)
        }
    }

    private var squadSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SQUAD")
                .font(.gbCaption)
                .foregroundStyle(GB.accent)
                .tracking(1.5)
                .padding(.horizontal, 16)
                .padding(.top, 20)

            let grouped = Dictionary(grouping: team.players) { $0.position }
            let sorted = grouped.sorted { $0.key.sortOrder < $1.key.sortOrder }

            ForEach(sorted, id: \.key) { pos, players in
                VStack(alignment: .leading, spacing: 6) {
                    Text(pos.label.uppercased())
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(pos.color)
                        .padding(.horizontal, 16)

                    ForEach(players.sorted { $0.stats.rating > $1.stats.rating }) { player in
                        NavigationLink(value: NavDestination.player(player)) {
                            PlayerCard(player: player)
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.top, 4)
            }
        }
    }
}
