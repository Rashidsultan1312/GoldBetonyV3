import Foundation
import SwiftUI

struct League: Identifiable, Hashable {
    let id: String
    let name: String
    let country: String
    let icon: String
    let color: Color
    let teams: [Team]
    let standings: [Standing]

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (l: League, r: League) -> Bool { l.id == r.id }
}

struct Team: Identifiable, Hashable {
    let id: String
    let name: String
    let shortName: String
    let city: String
    let country: String
    let stadium: String
    let capacity: Int
    let founded: Int
    let coach: String
    let league: String
    let rating: Double
    let icon: String
    let color: Color
    let players: [Player]

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (l: Team, r: Team) -> Bool { l.id == r.id }
}

struct Player: Identifiable, Hashable {
    let id: String
    let name: String
    let number: Int
    let position: Position
    let nationality: String
    let age: Int
    let stats: PlayerStats

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (l: Player, r: Player) -> Bool { l.id == r.id }
}

struct PlayerStats: Hashable {
    let appearances: Int
    let goals: Int
    let assists: Int
    let yellowCards: Int
    let redCards: Int
    let minutesPlayed: Int
    let rating: Double

    static let empty = PlayerStats(appearances: 0, goals: 0, assists: 0, yellowCards: 0, redCards: 0, minutesPlayed: 0, rating: 0)
}

enum Position: String, CaseIterable {
    case gk = "GK"
    case def = "DEF"
    case mid = "MID"
    case fwd = "FWD"

    var label: String {
        switch self {
        case .gk: "Goalkeeper"
        case .def: "Defender"
        case .mid: "Midfielder"
        case .fwd: "Forward"
        }
    }

    var shortLabel: String { rawValue }

    var color: Color {
        switch self {
        case .gk: .orange
        case .def: .blue
        case .mid: .green
        case .fwd: .red
        }
    }

    var sortOrder: Int {
        switch self {
        case .gk: 0
        case .def: 1
        case .mid: 2
        case .fwd: 3
        }
    }
}

struct Standing: Identifiable, Hashable {
    let id: String
    let position: Int
    let teamId: String
    let teamName: String
    let played: Int
    let won: Int
    let drawn: Int
    let lost: Int
    let goalsFor: Int
    let goalsAgainst: Int
    let points: Int
    let form: [MatchResult]

    var goalDifference: Int { goalsFor - goalsAgainst }
}

enum MatchResult: String {
    case win = "W"
    case draw = "D"
    case loss = "L"

    var color: Color {
        switch self {
        case .win: .green
        case .draw: .orange
        case .loss: .red
        }
    }
}

struct Match: Identifiable, Hashable {
    let id: String
    let homeTeam: String
    let awayTeam: String
    let homeScore: Int?
    let awayScore: Int?
    let date: Date
    let league: String
    let venue: String
    let round: String

    var isPlayed: Bool { homeScore != nil }

    var scoreText: String {
        guard let h = homeScore, let a = awayScore else { return "–" }
        return "\(h) : \(a)"
    }

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (l: Match, r: Match) -> Bool { l.id == r.id }
}

enum NavDestination: Hashable {
    case league(League)
    case team(Team)
    case player(Player)
    case standings(League)
}
