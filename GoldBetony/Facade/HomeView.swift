import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: SportsStore

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                if store.isLoading {
                    loadingView
                } else {
                    VStack(spacing: 24) {
                        if store.isOffline {
                            statusBanner("No connection — showing saved data", icon: "wifi.slash", color: GB.draw)
                        } else if store.isRateLimited {
                            statusBanner("API temporarily unavailable — will update automatically", icon: "clock.arrow.circlepath", color: GB.draw)
                        }
                        heroSection
                        upcomingSection
                        standingsSnippet
                        recentSection
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(GB.bg.ignoresSafeArea())
            .navigationTitle("Gold Betony")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }

    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .tint(GB.accent)
                .scaleEffect(1.3)
            Text("Loading matches...")
                .font(.gbCaption)
                .foregroundStyle(GB.textSecondary)
        }
        .frame(maxWidth: .infinity, minHeight: 400)
    }

    private func statusBanner(_ text: String, icon: String, color: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 12))
            Text(text)
                .font(.system(size: 12))
        }
        .foregroundStyle(color)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, 16)
    }

    // MARK: - Hero

    private var heroSection: some View {
        Group {
            if let next = store.upcoming.first {
                VStack(spacing: 14) {
                    HStack {
                        Text("NEXT MATCH")
                            .font(.gbCaption)
                            .foregroundStyle(GB.accent)
                            .tracking(1.5)
                        Spacer()
                        Text(next.strLeague)
                            .font(.gbCaption)
                            .foregroundStyle(GB.textSecondary)
                    }

                    HStack(spacing: 0) {
                        teamCol(next.strHomeTeam, badge: next.strHomeTeamBadge)
                        VStack(spacing: 6) {
                            if let round = next.intRound {
                                Text("Round \(round)")
                                    .font(.system(size: 10))
                                    .foregroundStyle(GB.textMuted)
                            }
                            Text(formatTimestamp(next.strTimestamp))
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(GB.accent)
                            if let venue = next.strVenue {
                                Text(venue)
                                    .font(.system(size: 10))
                                    .foregroundStyle(GB.textMuted)
                                    .lineLimit(1)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        teamCol(next.strAwayTeam, badge: next.strAwayTeamBadge)
                    }
                }
                .padding(20)
                .background(
                    ZStack {
                        GB.card
                        LinearGradient(colors: [GB.purple.opacity(0.15), .clear], startPoint: .topLeading, endPoint: .bottomTrailing)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(GB.border, lineWidth: 0.5))
                .padding(.horizontal, 16)
                .padding(.top, 8)
            }
        }
    }

    private func teamCol(_ name: String, badge: String?) -> some View {
        VStack(spacing: 10) {
            RemoteBadge(url: badge, size: 52)
            Text(name)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(GB.text)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Upcoming

    private var upcomingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Upcoming", icon: "calendar")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(store.upcoming.dropFirst().prefix(8))) { ev in
                        MiniEventCard(event: ev)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    // MARK: - Standings Snippet

    private var standingsSnippet: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Premier League", icon: "trophy.fill")

            if let epl = store.standings["4328"]?.prefix(6) {
                VStack(spacing: 0) {
                    HStack {
                        Text("#").frame(width: 22)
                        Text("Team").frame(maxWidth: .infinity, alignment: .leading)
                        Text("P").frame(width: 24)
                        Text("GD").frame(width: 30)
                        Text("Pts").frame(width: 30)
                    }
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(GB.textMuted)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)

                    ForEach(Array(epl)) { s in
                        HStack(spacing: 8) {
                            Text(s.intRank)
                                .font(.system(size: 12, weight: .bold, design: .monospaced))
                                .foregroundStyle(Int(s.intRank) ?? 0 <= 4 ? GB.accent : GB.textSecondary)
                                .frame(width: 22)

                            RemoteBadge(url: s.strBadge, size: 22)

                            Text(s.strTeam)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(GB.text)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)

                            Text(s.intPlayed)
                                .frame(width: 24)
                            Text(s.intGoalDifference)
                                .frame(width: 30)
                            Text(s.intPoints)
                                .fontWeight(.bold)
                                .frame(width: 30)
                        }
                        .font(.system(size: 12))
                        .foregroundStyle(GB.textSecondary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Int(s.intRank) ?? 0 % 2 == 0 ? GB.surface.opacity(0.5) : Color.clear)
                    }
                }
                .background(GB.card)
                .clipShape(RoundedRectangle(cornerRadius: GB.radius))
                .overlay(RoundedRectangle(cornerRadius: GB.radius).stroke(GB.border, lineWidth: 0.5))
                .padding(.horizontal, 16)
            }
        }
    }

    // MARK: - Recent Results

    private var recentSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Recent Results", icon: "clock.fill")

            VStack(spacing: 8) {
                ForEach(Array(store.results.prefix(6))) { ev in
                    LiveResultRow(event: ev)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    // MARK: - Helpers

    private func sectionHeader(_ title: String, icon: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundStyle(GB.accent)
            Text(title)
                .font(.gbH2)
                .foregroundStyle(GB.text)
        }
        .padding(.horizontal, 16)
    }

    private func formatTimestamp(_ ts: String?) -> String {
        guard let ts else { return "TBD" }
        let df = ISO8601DateFormatter()
        df.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = df.date(from: ts) {
            let f = DateFormatter()
            f.dateFormat = "d MMM, HH:mm"
            f.locale = Locale(identifier: "en_US")
            return f.string(from: date)
        }
        let df2 = DateFormatter()
        df2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = df2.date(from: ts) {
            let f = DateFormatter()
            f.dateFormat = "d MMM, HH:mm"
            f.locale = Locale(identifier: "en_US")
            return f.string(from: date)
        }
        return ts
    }
}

// MARK: - Remote Badge

struct RemoteBadge: View {
    let url: String?
    var size: CGFloat = 38

    var body: some View {
        if let str = url, let u = URL(string: str.replacingOccurrences(of: "/tiny", with: "")) {
            AsyncImage(url: u) { phase in
                switch phase {
                case .success(let img):
                    img.resizable().scaledToFit()
                case .failure:
                    placeholder
                case .empty:
                    ProgressView().tint(GB.textMuted)
                @unknown default:
                    placeholder
                }
            }
            .frame(width: size, height: size)
        } else {
            placeholder
        }
    }

    private var placeholder: some View {
        Circle()
            .fill(GB.surface)
            .frame(width: size, height: size)
            .overlay(
                Image(systemName: "shield.fill")
                    .font(.system(size: size * 0.45))
                    .foregroundStyle(GB.textMuted)
            )
    }
}

// MARK: - Mini Event Card

struct MiniEventCard: View {
    let event: APIEvent

    var body: some View {
        VStack(spacing: 10) {
            Text(event.strLeague)
                .font(.system(size: 9, weight: .bold))
                .foregroundStyle(GB.purple)
                .lineLimit(1)

            HStack(spacing: 10) {
                VStack(spacing: 5) {
                    RemoteBadge(url: event.strHomeTeamBadge, size: 28)
                    Text(event.strHomeTeam)
                        .lineLimit(1)
                }
                .frame(width: 60)

                Text("vs")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(GB.textMuted)

                VStack(spacing: 5) {
                    RemoteBadge(url: event.strAwayTeamBadge, size: 28)
                    Text(event.strAwayTeam)
                        .lineLimit(1)
                }
                .frame(width: 60)
            }
            .font(.system(size: 10, weight: .semibold))
            .foregroundStyle(GB.text)

            if let date = event.dateEvent {
                Text(shortDate(date))
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(GB.accent)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 12)
        .frame(width: 180)
        .background(GB.card)
        .clipShape(RoundedRectangle(cornerRadius: GB.radius, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: GB.radius, style: .continuous).stroke(GB.border, lineWidth: 0.5))
    }

    private func shortDate(_ d: String) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        guard let date = df.date(from: d) else { return d }
        df.dateFormat = "EEE d MMM"
        df.locale = Locale(identifier: "en_US")
        return df.string(from: date)
    }
}

// MARK: - Live Result Row

struct LiveResultRow: View {
    let event: APIEvent

    var body: some View {
        HStack(spacing: 8) {
            RemoteBadge(url: event.strHomeTeamBadge, size: 28)

            Text(event.strHomeTeam)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(GB.text)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)

            HStack(spacing: 3) {
                let h = Int(event.intHomeScore ?? "") ?? 0
                let a = Int(event.intAwayScore ?? "") ?? 0
                Text("\(h)")
                    .foregroundStyle(h > a ? GB.accent : GB.text)
                Text(":")
                    .foregroundStyle(GB.textMuted)
                Text("\(a)")
                    .foregroundStyle(a > h ? GB.accent : GB.text)
            }
            .font(.system(size: 16, weight: .black, design: .rounded))
            .frame(width: 50)

            Text(event.strAwayTeam)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(GB.text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)

            RemoteBadge(url: event.strAwayTeamBadge, size: 28)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(GB.card)
        .clipShape(RoundedRectangle(cornerRadius: GB.radiusSm))
        .overlay(RoundedRectangle(cornerRadius: GB.radiusSm).stroke(GB.border, lineWidth: 0.5))
    }
}
