import Foundation

enum SportsAPI {
    static let base = "https://www.thesportsdb.com/api/v1/json/3"

    struct LeagueInfo: Sendable {
        let id: String
        let name: String
        let season: String
        let badge: String
    }

    static let leagues: [LeagueInfo] = [
        LeagueInfo(id: "4328", name: "Premier League", season: "2025-2026", badge: "https://r2.thesportsdb.com/images/media/league/badge/gasy9d1737743125.png"),
        LeagueInfo(id: "4335", name: "La Liga", season: "2025-2026", badge: "https://r2.thesportsdb.com/images/media/league/badge/ja4it51687628717.png"),
        LeagueInfo(id: "4332", name: "Serie A", season: "2025-2026", badge: "https://r2.thesportsdb.com/images/media/league/badge/67q3q21679951383.png"),
        LeagueInfo(id: "4331", name: "Bundesliga", season: "2025-2026", badge: "https://r2.thesportsdb.com/images/media/league/badge/teqh1b1679952008.png"),
        LeagueInfo(id: "4334", name: "Ligue 1", season: "2025-2026", badge: "https://r2.thesportsdb.com/images/media/league/badge/9f7z9d1742983155.png"),
        LeagueInfo(id: "4337", name: "Eredivisie", season: "2025-2026", badge: "https://r2.thesportsdb.com/images/media/league/badge/5cdsu21725984946.png"),
        LeagueInfo(id: "4338", name: "Belgian Pro League", season: "2025-2026", badge: "https://r2.thesportsdb.com/images/media/league/badge/mjit7n1593634474.png"),
        LeagueInfo(id: "4330", name: "Scottish Premiership", season: "2025-2026", badge: "https://r2.thesportsdb.com/images/media/league/badge/72d3zc1688333496.png"),
    ]

    enum APIError: Error {
        case rateLimited
        case networkError
    }

    private static func fetch<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        if let http = response as? HTTPURLResponse {
            if http.statusCode == 429 || http.statusCode == 1015 { throw APIError.rateLimited }
            if http.statusCode != 200 { throw APIError.networkError }
            if let body = String(data: data, encoding: .utf8), body.contains("error code: 1015") {
                throw APIError.rateLimited
            }
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    static func fetchStandings(leagueId: String, season: String) async -> (data: [APIStanding], rateLimited: Bool) {
        guard let url = URL(string: "\(base)/lookuptable.php?l=\(leagueId)&s=\(season)") else { return ([], false) }
        do {
            let resp: StandingsResponse = try await fetch(url: url)
            return (resp.table ?? [], false)
        } catch APIError.rateLimited { return ([], true) }
        catch { return ([], false) }
    }

    static func fetchNextEvents(leagueId: String) async -> (data: [APIEvent], rateLimited: Bool) {
        guard let url = URL(string: "\(base)/eventsnextleague.php?id=\(leagueId)") else { return ([], false) }
        do {
            let resp: EventsResponse = try await fetch(url: url)
            return (resp.events ?? [], false)
        } catch APIError.rateLimited { return ([], true) }
        catch { return ([], false) }
    }

    static func fetchPastEvents(leagueId: String) async -> (data: [APIEvent], rateLimited: Bool) {
        guard let url = URL(string: "\(base)/eventspastleague.php?id=\(leagueId)") else { return ([], false) }
        do {
            let resp: EventsResponse = try await fetch(url: url)
            return (resp.events ?? [], false)
        } catch APIError.rateLimited { return ([], true) }
        catch { return ([], false) }
    }

    static func fetchTeams(leagueId: String) async -> (data: [APITeam], rateLimited: Bool) {
        guard let url = URL(string: "\(base)/lookup_all_teams.php?id=\(leagueId)") else { return ([], false) }
        do {
            let resp: TeamsResponse = try await fetch(url: url)
            return (resp.teams ?? [], false)
        } catch APIError.rateLimited { return ([], true) }
        catch { return ([], false) }
    }

    static func fetchPlayers(teamId: String) async -> [APIPlayer] {
        guard let url = URL(string: "\(base)/lookup_all_players.php?id=\(teamId)") else { return [] }
        for attempt in 0..<3 {
            if attempt > 0 { try? await Task.sleep(nanoseconds: UInt64(attempt) * 2_000_000_000) }
            do {
                let resp: PlayersResponse = try await fetch(url: url)
                let all = resp.player ?? []
                let staff = Set(["Manager", "Assistant Coach", "Coach", "Goalkeeping Coach", "Fitness Coach"])
                let filtered = all.filter { !staff.contains($0.strPosition ?? "") }
                if !filtered.isEmpty { return filtered }
            } catch { continue }
        }
        return []
    }
}

// MARK: - Response Models

struct StandingsResponse: Decodable { let table: [APIStanding]? }
struct EventsResponse: Decodable { let events: [APIEvent]? }
struct TeamsResponse: Decodable { let teams: [APITeam]? }
struct PlayersResponse: Decodable { let player: [APIPlayer]? }

struct APIStanding: Codable, Identifiable {
    var id: String { idStanding }
    let idStanding: String
    let intRank: String
    let idTeam: String
    let strTeam: String
    let strBadge: String?
    let strForm: String?
    let intPlayed: String
    let intWin: String
    let intDraw: String
    let intLoss: String
    let intGoalsFor: String
    let intGoalsAgainst: String
    let intGoalDifference: String
    let intPoints: String
}

struct APIEvent: Codable, Identifiable, Hashable {
    var id: String { idEvent }
    let idEvent: String
    let strEvent: String
    let idLeague: String?
    let strLeague: String
    let strSeason: String
    let strHomeTeam: String
    let strAwayTeam: String
    let intHomeScore: String?
    let intAwayScore: String?
    let intRound: String?
    let dateEvent: String?
    let strTime: String?
    let strVenue: String?
    let strHomeTeamBadge: String?
    let strAwayTeamBadge: String?
    let strTimestamp: String?
}

struct APITeam: Codable, Identifiable, Hashable {
    var id: String { idTeam }
    let idTeam: String
    let strTeam: String
    let strTeamShort: String?
    let strAlternate: String?
    let intFormedYear: String?
    let strStadium: String?
    let intStadiumCapacity: String?
    let strCountry: String?
    let strManager: String?
    let strBadge: String?
    let strDescriptionEN: String?
}

struct APIPlayer: Codable, Identifiable, Hashable {
    var id: String { idPlayer }
    let idPlayer: String
    let strPlayer: String
    let strNumber: String?
    let strPosition: String?
    let strNationality: String?
    let dateBorn: String?
    let strThumb: String?
    let strCutout: String?
    let strDescriptionEN: String?
    let strHeight: String?
    let strWeight: String?
    let strTeam: String?
}
