import SwiftUI

@MainActor
final class SportsStore: ObservableObject {
    static let shared = SportsStore()

    @Published var standings: [String: [APIStanding]] = [:]
    @Published var upcoming: [APIEvent] = []
    @Published var results: [APIEvent] = []
    @Published var teams: [String: [APITeam]] = [:]
    @Published var players: [String: [APIPlayer]] = [:]
    @Published var isLoading = true
    @Published var isOffline = false
    @Published var isRateLimited = false

    private var loaded = false
    private var playersLoading: Set<String> = []

    private static let cacheKey = "gb_cache_v4"
    private static let cacheAgeKey = "gb_cache_date_v4"
    private static let playersCacheKey = "gb_players_v2"
    private static let cacheTTL: TimeInterval = 6 * 3600

    func loadIfNeeded() async {
        guard !loaded else { return }
        loaded = true

        if loadFromCache() {
            isLoading = false
            Task { await refreshFromAPI() }
        } else {
            isLoading = true
            await refreshFromAPI()
            if standings.isEmpty { loadFallback(); isOffline = true }
            isLoading = false
        }
    }

    func loadPlayers(teamId: String) async {
        if let cached = players[teamId], !cached.isEmpty { return }
        guard !playersLoading.contains(teamId) else { return }
        playersLoading.insert(teamId)
        let p = await SportsAPI.fetchPlayers(teamId: teamId)
        if !p.isEmpty {
            players[teamId] = p
            savePlayersCache()
        }
        playersLoading.remove(teamId)
    }

    private func refreshFromAPI() async {
        var allUp: [APIEvent] = []
        var allRes: [APIEvent] = []
        var allSt: [String: [APIStanding]] = [:]
        var allTm: [String: [APITeam]] = [:]
        var ok = false
        var rateLimited = false

        let leagues = SportsAPI.leagues
        for i in stride(from: 0, to: leagues.count, by: 2) {
            let batch = Array(leagues[i..<min(i + 2, leagues.count)])
            await withTaskGroup(of: (String, [APIStanding], [APITeam], [APIEvent], [APIEvent], Bool).self) { group in
                for l in batch {
                    group.addTask {
                        let s = await SportsAPI.fetchStandings(leagueId: l.id, season: l.season)
                        let t = await SportsAPI.fetchTeams(leagueId: l.id)
                        let n = await SportsAPI.fetchNextEvents(leagueId: l.id)
                        let p = await SportsAPI.fetchPastEvents(leagueId: l.id)
                        let rl = s.rateLimited || t.rateLimited || n.rateLimited || p.rateLimited
                        return (l.id, s.data, t.data, n.data, p.data, rl)
                    }
                }
                for await (id, s, t, n, p, rl) in group {
                    if !s.isEmpty || !t.isEmpty { ok = true }
                    if rl { rateLimited = true }
                    allSt[id] = s; allTm[id] = t
                    allUp.append(contentsOf: n); allRes.append(contentsOf: p)
                }
            }
            if i + 2 < leagues.count { try? await Task.sleep(nanoseconds: 500_000_000) }
        }

        if ok && !rateLimited {
            standings = allSt; teams = allTm
            upcoming = dedup(allUp).sorted { ($0.strTimestamp ?? "") < ($1.strTimestamp ?? "") }
            results = dedup(allRes).sorted { ($0.strTimestamp ?? "") > ($1.strTimestamp ?? "") }
            isOffline = false; isRateLimited = false
            saveToCache()
        } else if ok && rateLimited {
            for (id, s) in allSt where !s.isEmpty { standings[id] = s }
            for (id, t) in allTm where !t.isEmpty { teams[id] = t }
            let newUp = dedup(allUp); if !newUp.isEmpty { upcoming = newUp.sorted { ($0.strTimestamp ?? "") < ($1.strTimestamp ?? "") } }
            let newRes = dedup(allRes); if !newRes.isEmpty { results = newRes.sorted { ($0.strTimestamp ?? "") > ($1.strTimestamp ?? "") } }
            fillGapsFromFallback()
            isRateLimited = true; isOffline = false
            saveToCache()
        } else {
            loadFallback()
            isRateLimited = rateLimited; isOffline = !rateLimited
        }
    }

    private static let validLeagueNames: Set<String> = [
        "Premier League", "English Premier League",
        "La Liga", "Spanish La Liga",
        "Serie A", "Italian Serie A",
        "Bundesliga", "German Bundesliga",
        "Ligue 1", "French Ligue 1",
        "Eredivisie", "Dutch Eredivisie",
        "Belgian Pro League", "Belgian First Division A",
        "Scottish Premiership", "Scottish Premier League",
    ]

    private func dedup(_ events: [APIEvent]) -> [APIEvent] {
        var seen = Set<String>()
        return events.filter { ev in
            guard seen.insert(ev.idEvent).inserted else { return false }
            return Self.validLeagueNames.contains(ev.strLeague)
        }
    }

    private func fillGapsFromFallback() {
        for (id, s) in FallbackData.allStandings where standings[id]?.isEmpty ?? true { standings[id] = s }
        for (id, t) in FallbackData.allTeams where teams[id]?.isEmpty ?? true { teams[id] = t }
        if upcoming.isEmpty { upcoming = FallbackData.upcomingMatches }
        if results.isEmpty { results = FallbackData.recentResults }
    }

    private func loadFallback() {
        standings = FallbackData.allStandings
        teams = FallbackData.allTeams
        results = FallbackData.recentResults
        upcoming = FallbackData.upcomingMatches
    }

    func teamCount(for leagueId: String) -> Int {
        teams[leagueId]?.count ?? standings[leagueId]?.count ?? 0
    }

    // MARK: - Cache

    private func saveToCache() {
        if let encoded = try? JSONEncoder().encode(CacheData(standings: standings, upcoming: upcoming, results: results, teams: teams)) {
            UserDefaults.standard.set(encoded, forKey: Self.cacheKey)
            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: Self.cacheAgeKey)
        }
    }

    private func savePlayersCache() {
        if let encoded = try? JSONEncoder().encode(players) {
            UserDefaults.standard.set(encoded, forKey: Self.playersCacheKey)
        }
    }

    private func loadFromCache() -> Bool {
        let ts = UserDefaults.standard.double(forKey: Self.cacheAgeKey)
        guard ts > 0, Date().timeIntervalSince1970 - ts < Self.cacheTTL else { return false }
        guard let raw = UserDefaults.standard.data(forKey: Self.cacheKey),
              let cached = try? JSONDecoder().decode(CacheData.self, from: raw) else { return false }
        standings = cached.standings
        upcoming = dedup(cached.upcoming)
        results = dedup(cached.results)
        teams = cached.teams
        if let pData = UserDefaults.standard.data(forKey: Self.playersCacheKey),
           let p = try? JSONDecoder().decode([String: [APIPlayer]].self, from: pData) {
            players = p
        }
        return true
    }
}

private struct CacheData: Codable {
    let standings: [String: [APIStanding]]
    let upcoming: [APIEvent]
    let results: [APIEvent]
    let teams: [String: [APITeam]]
}
