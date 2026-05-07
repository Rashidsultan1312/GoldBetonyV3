import SwiftUI

struct LiveStandingsView: View {
    let leagueId: String
    let leagueName: String
    @EnvironmentObject var store: SportsStore
    @State private var tab = 0

    var standings: [APIStanding] { store.standings[leagueId] ?? [] }
    var teamsList: [APITeam] { store.teams[leagueId] ?? [] }

    private var hasStandings: Bool { !standings.isEmpty }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                header
                if hasStandings {
                    segmentPicker
                    if tab == 0 {
                        standingsTable
                    } else {
                        teamsGrid
                    }
                } else {
                    teamsGrid
                }
            }
            .padding(.bottom, 20)
        }
        .background(GB.bg.ignoresSafeArea())
        .navigationTitle(leagueName)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        ZStack {
            GB.heroGrad.frame(height: 100)
            VStack(spacing: 6) {
                Text(leagueName)
                    .font(.gbTitle)
                    .foregroundStyle(GB.text)
                Text("Season 2025/26 · \(hasStandings ? standings.count : teamsList.count) teams")
                    .font(.gbCaption)
                    .foregroundStyle(GB.textSecondary)
            }
        }
    }

    private var segmentPicker: some View {
        HStack(spacing: 0) {
            segBtn("Standings", idx: 0)
            segBtn("Teams", idx: 1)
        }
        .padding(3)
        .background(GB.surface)
        .clipShape(RoundedRectangle(cornerRadius: GB.radiusSm))
        .padding(.horizontal, 16)
    }

    private func segBtn(_ title: String, idx: Int) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) { tab = idx }
        } label: {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(tab == idx ? GB.onAccent : GB.textSecondary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(tab == idx ? GB.accent : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }

    // MARK: - Standings Table

    private var standingsTable: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("#").frame(width: 26, alignment: .center)
                Text("Team").frame(maxWidth: .infinity, alignment: .leading)
                Text("P").frame(width: 26)
                Text("W").frame(width: 26)
                Text("D").frame(width: 26)
                Text("L").frame(width: 26)
                Text("GD").frame(width: 32)
                Text("Pts").frame(width: 30)
                Text("Form").frame(width: 56)
            }
            .font(.system(size: 10, weight: .bold))
            .foregroundStyle(GB.textMuted)
            .padding(.horizontal, 10)
            .padding(.vertical, 8)

            ForEach(standings) { s in
                let rank = Int(s.intRank) ?? 0
                HStack(spacing: 0) {
                    Text(s.intRank)
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundStyle(rank <= 4 ? GB.accent : (rank >= standings.count - 2 ? GB.loss : GB.textSecondary))
                        .frame(width: 26, alignment: .center)

                    HStack(spacing: 6) {
                        RemoteBadge(url: s.strBadge, size: 20)
                        Text(s.strTeam)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(GB.text)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Group {
                        Text(s.intPlayed).frame(width: 26)
                        Text(s.intWin).frame(width: 26)
                        Text(s.intDraw).frame(width: 26)
                        Text(s.intLoss).frame(width: 26)
                    }
                    .font(.system(size: 11))
                    .foregroundStyle(GB.textSecondary)

                    Text(gdText(s.intGoalDifference))
                        .font(.system(size: 11))
                        .foregroundStyle(Int(s.intGoalDifference) ?? 0 > 0 ? GB.win : GB.textSecondary)
                        .frame(width: 32)

                    Text(s.intPoints)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(GB.text)
                        .frame(width: 30)

                    formDots(s.strForm ?? "")
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 9)
                .background(rank % 2 == 0 ? GB.surface.opacity(0.4) : Color.clear)

                if rank == 4 || rank == standings.count - 3 {
                    Rectangle().fill(GB.border).frame(height: 0.5).padding(.horizontal, 10)
                }
            }

            if let form = standings.first?.strForm, !form.isEmpty {
                HStack(spacing: 16) {
                    formLegend("CL", color: GB.accent)
                    formLegend("EL", color: GB.purple)
                    formLegend("REL", color: GB.loss)
                }
                .padding(.vertical, 10)
            }
        }
        .background(GB.card)
        .clipShape(RoundedRectangle(cornerRadius: GB.radius))
        .overlay(RoundedRectangle(cornerRadius: GB.radius).stroke(GB.border, lineWidth: 0.5))
        .padding(.horizontal, 16)
    }

    private func gdText(_ gd: String) -> String {
        let v = Int(gd) ?? 0
        return v > 0 ? "+\(v)" : "\(v)"
    }

    private func formDots(_ form: String) -> some View {
        HStack(spacing: 3) {
            ForEach(Array(form.suffix(5).enumerated()), id: \.offset) { _, ch in
                Circle()
                    .fill(formColor(ch))
                    .frame(width: 8, height: 8)
            }
        }
        .frame(width: 56)
    }

    private func formColor(_ ch: Character) -> Color {
        switch ch {
        case "W": return GB.win
        case "D": return GB.draw
        case "L": return GB.loss
        default: return GB.textMuted
        }
    }

    private func formLegend(_ label: String, color: Color) -> some View {
        HStack(spacing: 4) {
            Circle().fill(color).frame(width: 6, height: 6)
            Text(label)
                .font(.system(size: 9, weight: .medium))
                .foregroundStyle(GB.textMuted)
        }
    }

    // MARK: - Teams Grid

    private var teamsGrid: some View {
        LazyVStack(spacing: 10) {
            if teamsList.isEmpty {
                VStack(spacing: 12) {
                    ProgressView().tint(GB.accent)
                    Text("Loading teams...")
                        .font(.gbCaption)
                        .foregroundStyle(GB.textMuted)
                }
                .frame(maxWidth: .infinity, minHeight: 200)
            } else {
                ForEach(teamsList) { team in
                    NavigationLink(value: team) {
                        APITeamRow(team: team)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .navigationDestination(for: APITeam.self) { team in
            APITeamDetailView(team: team, leagueId: leagueId)
                .environmentObject(store)
        }
    }
}

struct APITeamRow: View {
    let team: APITeam

    var body: some View {
        HStack(spacing: 14) {
            RemoteBadge(url: team.strBadge, size: 44)

            VStack(alignment: .leading, spacing: 3) {
                Text(team.strTeam)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(GB.text)
                HStack(spacing: 4) {
                    if let country = team.strCountry {
                        Text(country)
                    }
                    if let stadium = team.strStadium {
                        Text("·")
                        Text(stadium)
                    }
                }
                .font(.system(size: 11))
                .foregroundStyle(GB.textSecondary)
                .lineLimit(1)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(GB.textMuted)
        }
        .padding(14)
        .background(GB.card)
        .clipShape(RoundedRectangle(cornerRadius: GB.radius, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: GB.radius, style: .continuous).stroke(GB.border, lineWidth: 0.5))
    }
}

struct APITeamDetailView: View {
    let team: APITeam
    let leagueId: String
    @EnvironmentObject var store: SportsStore
    @AppStorage("favorites") private var favData = Data()

    private var isFav: Bool { favorites.contains(team.idTeam) }
    private var favorites: Set<String> {
        (try? JSONDecoder().decode(Set<String>.self, from: favData)) ?? []
    }
    private func toggleFav() {
        var set = favorites
        if set.contains(team.idTeam) { set.remove(team.idTeam) } else { set.insert(team.idTeam) }
        favData = (try? JSONEncoder().encode(set)) ?? Data()
    }

    private var standing: APIStanding? {
        store.standings[leagueId]?.first { $0.idTeam == team.idTeam }
    }
    private var squad: [APIPlayer] { store.players[team.idTeam] ?? [] }
    @State private var loadAttempted = false
    private var playersLoading: Bool { store.players[team.idTeam] == nil && !loadAttempted }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                headerView
                if let s = standing { statsRow(s) }
                infoSection
                squadSection
                if let desc = team.strDescriptionEN, !desc.isEmpty {
                    descSection(desc)
                }
            }
            .padding(.bottom, 20)
        }
        .background(GB.bg.ignoresSafeArea())
        .navigationTitle(team.strTeamShort ?? team.strTeam)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: toggleFav) {
                Image(systemName: isFav ? "star.fill" : "star")
                    .foregroundStyle(GB.accent)
            }
        }
        .task {
            await store.loadPlayers(teamId: team.idTeam)
            loadAttempted = true
        }
    }

    private var headerView: some View {
        ZStack {
            LinearGradient(colors: [GB.purple.opacity(0.3), GB.bg], startPoint: .top, endPoint: .bottom)
                .frame(height: 180)
            VStack(spacing: 12) {
                RemoteBadge(url: team.strBadge, size: 80)
                Text(team.strTeam)
                    .font(.gbTitle)
                    .foregroundStyle(GB.text)
                if let manager = team.strManager, !manager.isEmpty {
                    HStack(spacing: 4) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 10))
                        Text(manager)
                    }
                    .font(.gbCaption)
                    .foregroundStyle(GB.textSecondary)
                }
            }
        }
    }

    private func statsRow(_ s: APIStanding) -> some View {
        HStack(spacing: 0) {
            statCell("Rank", "#\(s.intRank)")
            vert
            statCell("Points", s.intPoints)
            vert
            statCell("Won", s.intWin)
            vert
            statCell("GD", gdText(s.intGoalDifference))
        }
        .padding(.vertical, 16)
        .background(GB.card)
        .clipShape(RoundedRectangle(cornerRadius: GB.radius))
        .overlay(RoundedRectangle(cornerRadius: GB.radius).stroke(GB.border, lineWidth: 0.5))
        .padding(.horizontal, 16)
    }

    private func statCell(_ label: String, _ value: String) -> some View {
        VStack(spacing: 4) {
            Text(value).font(.system(size: 20, weight: .bold)).foregroundStyle(GB.accent)
            Text(label).font(.system(size: 10, weight: .medium)).foregroundStyle(GB.textMuted)
        }
        .frame(maxWidth: .infinity)
    }

    private var vert: some View { Rectangle().fill(GB.border).frame(width: 0.5, height: 36) }

    private func gdText(_ gd: String) -> String {
        let v = Int(gd) ?? 0; return v > 0 ? "+\(v)" : "\(v)"
    }

    private var infoSection: some View {
        VStack(spacing: 10) {
            if let stadium = team.strStadium { infoRow("building.2.fill", "Stadium", stadium) }
            if let cap = team.intStadiumCapacity, let c = Int(cap), c > 0 { infoRow("person.3.fill", "Capacity", c.formatted()) }
            if let year = team.intFormedYear { infoRow("calendar", "Founded", year) }
            if let country = team.strCountry { infoRow("flag.fill", "Country", country) }
        }
        .padding(16)
        .background(GB.card)
        .clipShape(RoundedRectangle(cornerRadius: GB.radius))
        .overlay(RoundedRectangle(cornerRadius: GB.radius).stroke(GB.border, lineWidth: 0.5))
        .padding(.horizontal, 16)
    }

    private func infoRow(_ icon: String, _ label: String, _ value: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon).font(.system(size: 14)).foregroundStyle(GB.purple).frame(width: 20)
            Text(label).font(.system(size: 13)).foregroundStyle(GB.textSecondary)
            Spacer()
            Text(value).font(.system(size: 13, weight: .medium)).foregroundStyle(GB.text)
        }
    }

    // MARK: - Squad

    private var squadSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("SQUAD")
                    .font(.gbCaption)
                    .foregroundStyle(GB.accent)
                    .tracking(1.5)
                Spacer()
                if !squad.isEmpty {
                    Text("\(squad.count) players")
                        .font(.system(size: 11))
                        .foregroundStyle(GB.textMuted)
                }
            }
            .padding(.horizontal, 16)

            if squad.isEmpty && playersLoading {
                HStack {
                    Spacer()
                    ProgressView().tint(GB.accent)
                    Text("Loading squad...").font(.gbCaption).foregroundStyle(GB.textMuted)
                    Spacer()
                }
                .padding(.vertical, 20)
            } else if squad.isEmpty {
                Text("Squad data not available")
                    .font(.gbCaption)
                    .foregroundStyle(GB.textMuted)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
            } else {
                ForEach(squad) { player in
                    PlayerRow(player: player)
                        .padding(.horizontal, 16)
                }
            }
        }
        .padding(.top, 8)
    }

    private func descSection(_ text: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("ABOUT")
                .font(.gbCaption)
                .foregroundStyle(GB.accent)
                .tracking(1.5)
            Text(text)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(GB.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .background(GB.card)
        .clipShape(RoundedRectangle(cornerRadius: GB.radius))
        .overlay(RoundedRectangle(cornerRadius: GB.radius).stroke(GB.border, lineWidth: 0.5))
        .padding(.horizontal, 16)
    }
}

// MARK: - Player Row with Photo

struct PlayerRow: View {
    let player: APIPlayer

    var body: some View {
        HStack(spacing: 12) {
            playerPhoto

            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 6) {
                    if let num = player.strNumber, !num.isEmpty {
                        Text("#\(num)")
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                            .foregroundStyle(GB.accent)
                    }
                    Text(player.strPlayer)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(GB.text)
                        .lineLimit(1)
                }

                HStack(spacing: 6) {
                    if let pos = player.strPosition {
                        Text(pos)
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(posColor(pos))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(posColor(pos).opacity(0.12))
                            .clipShape(Capsule())
                    }
                    if let nat = player.strNationality {
                        Text(nat)
                            .font(.system(size: 11))
                            .foregroundStyle(GB.textSecondary)
                    }
                    if let born = player.dateBorn, born.count >= 4 {
                        Text("·")
                            .foregroundStyle(GB.textMuted)
                        Text(age(from: born))
                            .font(.system(size: 11))
                            .foregroundStyle(GB.textSecondary)
                    }
                }
            }

            Spacer()
        }
        .padding(10)
        .background(GB.surface)
        .clipShape(RoundedRectangle(cornerRadius: GB.radiusSm))
        .overlay(RoundedRectangle(cornerRadius: GB.radiusSm).stroke(GB.border, lineWidth: 0.5))
    }

    private var playerPhoto: some View {
        Group {
            if let thumb = player.strThumb ?? player.strCutout,
               let url = URL(string: thumb.replacingOccurrences(of: "/tiny", with: "")) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let img):
                        img.resizable().scaledToFill()
                    default:
                        photoPlaceholder
                    }
                }
            } else {
                photoPlaceholder
            }
        }
        .frame(width: 44, height: 44)
        .clipShape(Circle())
    }

    private var photoPlaceholder: some View {
        Circle()
            .fill(GB.card)
            .overlay(
                Image(systemName: "person.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(GB.textMuted)
            )
    }

    private func posColor(_ pos: String) -> Color {
        let p = pos.lowercased()
        if p.contains("goal") { return .orange }
        if p.contains("back") || p.contains("defen") { return .blue }
        if p.contains("mid") { return .green }
        return .red
    }

    private func age(from born: String) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        guard let date = df.date(from: born) else { return "" }
        let years = Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0
        return "\(years) y.o."
    }
}
