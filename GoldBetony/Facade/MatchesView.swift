import SwiftUI

struct MatchesView: View {
    @EnvironmentObject var store: SportsStore
    @State private var showUpcoming = true

    private var items: [APIEvent] {
        showUpcoming ? store.upcoming : store.results
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                picker

                if store.isLoading {
                    Spacer()
                    ProgressView().tint(GB.accent)
                    Spacer()
                } else if items.isEmpty {
                    Spacer()
                    Text("No matches available")
                        .font(.gbBody)
                        .foregroundStyle(GB.textMuted)
                    Spacer()
                } else {
                    List {
                        ForEach(items) { ev in
                            LiveMatchCard(event: ev)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .background(GB.bg.ignoresSafeArea())
            .navigationTitle("Matches")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }

    private var picker: some View {
        HStack(spacing: 0) {
            pickerTab("Upcoming", active: showUpcoming) { showUpcoming = true }
            pickerTab("Results", active: !showUpcoming) { showUpcoming = false }
        }
        .padding(3)
        .background(GB.surface)
        .clipShape(RoundedRectangle(cornerRadius: GB.radiusSm))
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }

    private func pickerTab(_ title: String, active: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(active ? GB.onAccent : GB.textSecondary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(active ? GB.accent : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }
}

struct LiveMatchCard: View {
    let event: APIEvent

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 6) {
                RemoteBadge(url: event.strHomeTeamBadge, size: 28)

                Text(event.strHomeTeam)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(GB.text)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                centerContent
                    .frame(width: 52)

                Text(event.strAwayTeam)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(GB.text)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)

                RemoteBadge(url: event.strAwayTeamBadge, size: 28)
            }
        }
        .padding(12)
        .background(GB.card)
        .clipShape(RoundedRectangle(cornerRadius: GB.radius, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: GB.radius, style: .continuous).stroke(GB.border, lineWidth: 0.5))
    }

    @ViewBuilder
    private var centerContent: some View {
        if let hs = event.intHomeScore, let as_ = event.intAwayScore,
           let h = Int(hs), let a = Int(as_) {
            HStack(spacing: 2) {
                Text("\(h)")
                    .foregroundStyle(h > a ? GB.accent : GB.text)
                Text(":")
                    .foregroundStyle(GB.textMuted)
                Text("\(a)")
                    .foregroundStyle(a > h ? GB.accent : GB.text)
            }
            .font(.system(size: 16, weight: .black, design: .rounded))
        } else {
            VStack(spacing: 1) {
                Text(datePart)
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundStyle(GB.textSecondary)
                Text(timePart)
                    .font(.system(size: 13, weight: .black, design: .rounded))
                    .foregroundStyle(GB.accent)
            }
        }
    }

    private var datePart: String {
        guard let d = event.dateEvent else { return "" }
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        guard let date = df.date(from: d) else { return d }
        df.dateFormat = "d MMM"
        df.locale = Locale(identifier: "en_US")
        return df.string(from: date)
    }

    private var timePart: String {
        guard let t = event.strTime else { return "" }
        return String(t.prefix(5))
    }
}
