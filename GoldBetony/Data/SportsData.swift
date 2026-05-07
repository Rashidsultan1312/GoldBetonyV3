import SwiftUI

enum SportsData {
    static let leagues: [League] = [premierLeague, laLiga, serieA, bundesliga, ligue1, championsLeague]

    static func allTeams() -> [Team] { leagues.flatMap(\.teams) }
    static func team(by id: String) -> Team? { allTeams().first { $0.id == id } }

    // MARK: - Premier League 2025/26

    static let premierLeague = League(
        id: "epl", name: "Premier League", country: "England", icon: "crown.fill",
        color: Color(hex: 0x3D195B),
        teams: eplTeams,
        standings: eplStandings
    )

    static let eplTeams: [Team] = [
        Team(id: "mci", name: "Manchester City", shortName: "Man City", city: "Manchester", country: "England", stadium: "Etihad Stadium", capacity: 53400, founded: 1880, coach: "Pep Guardiola", league: "epl", rating: 4.8, icon: "shield.fill", color: Color(hex: 0x6CADDF), players: [
            Player(id: "mci01", name: "Ederson", number: 31, position: .gk, nationality: "Brazil", age: 31, stats: PlayerStats(appearances: 28, goals: 0, assists: 1, yellowCards: 2, redCards: 0, minutesPlayed: 2520, rating: 7.1)),
            Player(id: "mci02", name: "Ruben Dias", number: 3, position: .def, nationality: "Portugal", age: 27, stats: PlayerStats(appearances: 30, goals: 2, assists: 0, yellowCards: 4, redCards: 0, minutesPlayed: 2650, rating: 7.3)),
            Player(id: "mci03", name: "Kyle Walker", number: 2, position: .def, nationality: "England", age: 35, stats: PlayerStats(appearances: 22, goals: 0, assists: 3, yellowCards: 5, redCards: 0, minutesPlayed: 1800, rating: 6.8)),
            Player(id: "mci04", name: "Josko Gvardiol", number: 24, position: .def, nationality: "Croatia", age: 23, stats: PlayerStats(appearances: 31, goals: 5, assists: 2, yellowCards: 3, redCards: 0, minutesPlayed: 2700, rating: 7.2)),
            Player(id: "mci05", name: "Rodri", number: 16, position: .mid, nationality: "Spain", age: 28, stats: PlayerStats(appearances: 18, goals: 3, assists: 5, yellowCards: 3, redCards: 0, minutesPlayed: 1500, rating: 7.8)),
            Player(id: "mci06", name: "Kevin De Bruyne", number: 17, position: .mid, nationality: "Belgium", age: 33, stats: PlayerStats(appearances: 24, goals: 4, assists: 12, yellowCards: 1, redCards: 0, minutesPlayed: 1900, rating: 7.9)),
            Player(id: "mci07", name: "Bernardo Silva", number: 20, position: .mid, nationality: "Portugal", age: 30, stats: PlayerStats(appearances: 32, goals: 6, assists: 8, yellowCards: 2, redCards: 0, minutesPlayed: 2650, rating: 7.5)),
            Player(id: "mci08", name: "Phil Foden", number: 47, position: .mid, nationality: "England", age: 25, stats: PlayerStats(appearances: 29, goals: 10, assists: 6, yellowCards: 1, redCards: 0, minutesPlayed: 2200, rating: 7.6)),
            Player(id: "mci09", name: "Jeremy Doku", number: 11, position: .fwd, nationality: "Belgium", age: 23, stats: PlayerStats(appearances: 27, goals: 5, assists: 9, yellowCards: 2, redCards: 0, minutesPlayed: 1850, rating: 7.1)),
            Player(id: "mci10", name: "Erling Haaland", number: 9, position: .fwd, nationality: "Norway", age: 25, stats: PlayerStats(appearances: 32, goals: 28, assists: 4, yellowCards: 2, redCards: 0, minutesPlayed: 2750, rating: 8.2)),
            Player(id: "mci11", name: "Julian Alvarez", number: 19, position: .fwd, nationality: "Argentina", age: 25, stats: PlayerStats(appearances: 26, goals: 9, assists: 5, yellowCards: 1, redCards: 0, minutesPlayed: 1800, rating: 7.2)),
        ]),
        Team(id: "ars", name: "Arsenal", shortName: "Arsenal", city: "London", country: "England", stadium: "Emirates Stadium", capacity: 60704, founded: 1886, coach: "Mikel Arteta", league: "epl", rating: 4.7, icon: "shield.fill", color: Color(hex: 0xEF0107), players: [
            Player(id: "ars01", name: "David Raya", number: 22, position: .gk, nationality: "Spain", age: 29, stats: PlayerStats(appearances: 31, goals: 0, assists: 0, yellowCards: 1, redCards: 0, minutesPlayed: 2790, rating: 7.2)),
            Player(id: "ars02", name: "William Saliba", number: 2, position: .def, nationality: "France", age: 24, stats: PlayerStats(appearances: 30, goals: 2, assists: 1, yellowCards: 3, redCards: 0, minutesPlayed: 2680, rating: 7.4)),
            Player(id: "ars03", name: "Gabriel Magalhaes", number: 6, position: .def, nationality: "Brazil", age: 27, stats: PlayerStats(appearances: 29, goals: 4, assists: 0, yellowCards: 6, redCards: 0, minutesPlayed: 2600, rating: 7.3)),
            Player(id: "ars04", name: "Ben White", number: 4, position: .def, nationality: "England", age: 27, stats: PlayerStats(appearances: 28, goals: 1, assists: 4, yellowCards: 3, redCards: 0, minutesPlayed: 2400, rating: 7.0)),
            Player(id: "ars05", name: "Declan Rice", number: 41, position: .mid, nationality: "England", age: 26, stats: PlayerStats(appearances: 31, goals: 5, assists: 6, yellowCards: 7, redCards: 0, minutesPlayed: 2750, rating: 7.5)),
            Player(id: "ars06", name: "Martin Odegaard", number: 8, position: .mid, nationality: "Norway", age: 26, stats: PlayerStats(appearances: 30, goals: 8, assists: 10, yellowCards: 2, redCards: 0, minutesPlayed: 2550, rating: 7.8)),
            Player(id: "ars07", name: "Bukayo Saka", number: 7, position: .fwd, nationality: "England", age: 23, stats: PlayerStats(appearances: 31, goals: 14, assists: 11, yellowCards: 1, redCards: 0, minutesPlayed: 2600, rating: 8.0)),
            Player(id: "ars08", name: "Kai Havertz", number: 29, position: .fwd, nationality: "Germany", age: 26, stats: PlayerStats(appearances: 32, goals: 12, assists: 4, yellowCards: 3, redCards: 0, minutesPlayed: 2500, rating: 7.3)),
            Player(id: "ars09", name: "Gabriel Jesus", number: 9, position: .fwd, nationality: "Brazil", age: 28, stats: PlayerStats(appearances: 24, goals: 6, assists: 3, yellowCards: 1, redCards: 0, minutesPlayed: 1600, rating: 6.9)),
            Player(id: "ars10", name: "Leandro Trossard", number: 19, position: .fwd, nationality: "Belgium", age: 30, stats: PlayerStats(appearances: 29, goals: 8, assists: 5, yellowCards: 5, redCards: 0, minutesPlayed: 1850, rating: 7.1)),
        ]),
        Team(id: "liv", name: "Liverpool", shortName: "Liverpool", city: "Liverpool", country: "England", stadium: "Anfield", capacity: 61276, founded: 1892, coach: "Arne Slot", league: "epl", rating: 4.7, icon: "shield.fill", color: Color(hex: 0xC8102E), players: [
            Player(id: "liv01", name: "Alisson", number: 1, position: .gk, nationality: "Brazil", age: 32, stats: PlayerStats(appearances: 26, goals: 0, assists: 1, yellowCards: 0, redCards: 0, minutesPlayed: 2340, rating: 7.3)),
            Player(id: "liv02", name: "Virgil van Dijk", number: 4, position: .def, nationality: "Netherlands", age: 33, stats: PlayerStats(appearances: 31, goals: 3, assists: 1, yellowCards: 4, redCards: 0, minutesPlayed: 2780, rating: 7.4)),
            Player(id: "liv03", name: "Trent Alexander-Arnold", number: 66, position: .def, nationality: "England", age: 27, stats: PlayerStats(appearances: 28, goals: 2, assists: 10, yellowCards: 3, redCards: 0, minutesPlayed: 2300, rating: 7.3)),
            Player(id: "liv04", name: "Ryan Gravenberch", number: 38, position: .mid, nationality: "Netherlands", age: 23, stats: PlayerStats(appearances: 32, goals: 3, assists: 4, yellowCards: 5, redCards: 0, minutesPlayed: 2700, rating: 7.2)),
            Player(id: "liv05", name: "Alexis Mac Allister", number: 10, position: .mid, nationality: "Argentina", age: 26, stats: PlayerStats(appearances: 30, goals: 4, assists: 5, yellowCards: 4, redCards: 0, minutesPlayed: 2500, rating: 7.1)),
            Player(id: "liv06", name: "Mohamed Salah", number: 11, position: .fwd, nationality: "Egypt", age: 33, stats: PlayerStats(appearances: 32, goals: 20, assists: 13, yellowCards: 1, redCards: 0, minutesPlayed: 2700, rating: 8.1)),
            Player(id: "liv07", name: "Luis Diaz", number: 7, position: .fwd, nationality: "Colombia", age: 28, stats: PlayerStats(appearances: 30, goals: 11, assists: 4, yellowCards: 2, redCards: 0, minutesPlayed: 2300, rating: 7.2)),
            Player(id: "liv08", name: "Darwin Nunez", number: 9, position: .fwd, nationality: "Uruguay", age: 26, stats: PlayerStats(appearances: 28, goals: 13, assists: 3, yellowCards: 3, redCards: 1, minutesPlayed: 2000, rating: 7.0)),
            Player(id: "liv09", name: "Cody Gakpo", number: 18, position: .fwd, nationality: "Netherlands", age: 26, stats: PlayerStats(appearances: 29, goals: 9, assists: 6, yellowCards: 1, redCards: 0, minutesPlayed: 1900, rating: 7.3)),
        ]),
        Team(id: "che", name: "Chelsea", shortName: "Chelsea", city: "London", country: "England", stadium: "Stamford Bridge", capacity: 40341, founded: 1905, coach: "Enzo Maresca", league: "epl", rating: 4.4, icon: "shield.fill", color: Color(hex: 0x034694), players: [
            Player(id: "che01", name: "Robert Sanchez", number: 1, position: .gk, nationality: "Spain", age: 27, stats: PlayerStats(appearances: 25, goals: 0, assists: 0, yellowCards: 1, redCards: 0, minutesPlayed: 2250, rating: 6.8)),
            Player(id: "che02", name: "Wesley Fofana", number: 33, position: .def, nationality: "France", age: 24, stats: PlayerStats(appearances: 22, goals: 1, assists: 0, yellowCards: 3, redCards: 0, minutesPlayed: 1800, rating: 7.0)),
            Player(id: "che03", name: "Moises Caicedo", number: 25, position: .mid, nationality: "Ecuador", age: 23, stats: PlayerStats(appearances: 31, goals: 3, assists: 4, yellowCards: 8, redCards: 0, minutesPlayed: 2700, rating: 7.2)),
            Player(id: "che04", name: "Enzo Fernandez", number: 8, position: .mid, nationality: "Argentina", age: 24, stats: PlayerStats(appearances: 29, goals: 2, assists: 6, yellowCards: 4, redCards: 0, minutesPlayed: 2400, rating: 7.0)),
            Player(id: "che05", name: "Cole Palmer", number: 20, position: .mid, nationality: "England", age: 23, stats: PlayerStats(appearances: 32, goals: 18, assists: 10, yellowCards: 1, redCards: 0, minutesPlayed: 2750, rating: 8.0)),
            Player(id: "che06", name: "Nicolas Jackson", number: 15, position: .fwd, nationality: "Senegal", age: 24, stats: PlayerStats(appearances: 30, goals: 12, assists: 5, yellowCards: 3, redCards: 0, minutesPlayed: 2400, rating: 7.1)),
        ]),
        Team(id: "mun", name: "Manchester United", shortName: "Man Utd", city: "Manchester", country: "England", stadium: "Old Trafford", capacity: 74310, founded: 1878, coach: "Ruben Amorim", league: "epl", rating: 4.2, icon: "shield.fill", color: Color(hex: 0xDA291C), players: [
            Player(id: "mun01", name: "Andre Onana", number: 24, position: .gk, nationality: "Cameroon", age: 29, stats: PlayerStats(appearances: 30, goals: 0, assists: 0, yellowCards: 1, redCards: 0, minutesPlayed: 2700, rating: 6.7)),
            Player(id: "mun02", name: "Lisandro Martinez", number: 6, position: .def, nationality: "Argentina", age: 27, stats: PlayerStats(appearances: 25, goals: 1, assists: 1, yellowCards: 6, redCards: 1, minutesPlayed: 2100, rating: 7.0)),
            Player(id: "mun03", name: "Bruno Fernandes", number: 8, position: .mid, nationality: "Portugal", age: 31, stats: PlayerStats(appearances: 32, goals: 7, assists: 8, yellowCards: 6, redCards: 0, minutesPlayed: 2800, rating: 7.3)),
            Player(id: "mun04", name: "Kobbie Mainoo", number: 37, position: .mid, nationality: "England", age: 20, stats: PlayerStats(appearances: 28, goals: 3, assists: 4, yellowCards: 3, redCards: 0, minutesPlayed: 2200, rating: 7.1)),
            Player(id: "mun05", name: "Alejandro Garnacho", number: 17, position: .fwd, nationality: "Argentina", age: 21, stats: PlayerStats(appearances: 29, goals: 8, assists: 5, yellowCards: 2, redCards: 0, minutesPlayed: 2000, rating: 7.0)),
            Player(id: "mun06", name: "Rasmus Hojlund", number: 11, position: .fwd, nationality: "Denmark", age: 22, stats: PlayerStats(appearances: 27, goals: 10, assists: 2, yellowCards: 1, redCards: 0, minutesPlayed: 2100, rating: 6.9)),
            Player(id: "mun07", name: "Marcus Rashford", number: 10, position: .fwd, nationality: "England", age: 27, stats: PlayerStats(appearances: 20, goals: 5, assists: 3, yellowCards: 1, redCards: 0, minutesPlayed: 1400, rating: 6.5)),
        ]),
        Team(id: "tot", name: "Tottenham Hotspur", shortName: "Tottenham", city: "London", country: "England", stadium: "Tottenham Hotspur Stadium", capacity: 62850, founded: 1882, coach: "Ange Postecoglou", league: "epl", rating: 4.2, icon: "shield.fill", color: Color(hex: 0x132257), players: [
            Player(id: "tot01", name: "Guglielmo Vicario", number: 13, position: .gk, nationality: "Italy", age: 28, stats: PlayerStats(appearances: 28, goals: 0, assists: 0, yellowCards: 1, redCards: 0, minutesPlayed: 2520, rating: 6.9)),
            Player(id: "tot02", name: "Cristian Romero", number: 17, position: .def, nationality: "Argentina", age: 27, stats: PlayerStats(appearances: 26, goals: 2, assists: 0, yellowCards: 7, redCards: 1, minutesPlayed: 2200, rating: 7.1)),
            Player(id: "tot03", name: "James Maddison", number: 10, position: .mid, nationality: "England", age: 28, stats: PlayerStats(appearances: 29, goals: 6, assists: 7, yellowCards: 3, redCards: 0, minutesPlayed: 2300, rating: 7.2)),
            Player(id: "tot04", name: "Dejan Kulusevski", number: 21, position: .mid, nationality: "Sweden", age: 25, stats: PlayerStats(appearances: 31, goals: 5, assists: 8, yellowCards: 2, redCards: 0, minutesPlayed: 2500, rating: 7.1)),
            Player(id: "tot05", name: "Son Heung-min", number: 7, position: .fwd, nationality: "South Korea", age: 33, stats: PlayerStats(appearances: 30, goals: 14, assists: 6, yellowCards: 1, redCards: 0, minutesPlayed: 2400, rating: 7.5)),
            Player(id: "tot06", name: "Dominic Solanke", number: 19, position: .fwd, nationality: "England", age: 27, stats: PlayerStats(appearances: 29, goals: 11, assists: 3, yellowCards: 2, redCards: 0, minutesPlayed: 2200, rating: 7.0)),
        ]),
        Team(id: "new", name: "Newcastle United", shortName: "Newcastle", city: "Newcastle", country: "England", stadium: "St. James' Park", capacity: 52305, founded: 1892, coach: "Eddie Howe", league: "epl", rating: 4.3, icon: "shield.fill", color: Color(hex: 0x241F20), players: [
            Player(id: "new01", name: "Nick Pope", number: 22, position: .gk, nationality: "England", age: 33, stats: PlayerStats(appearances: 20, goals: 0, assists: 0, yellowCards: 1, redCards: 0, minutesPlayed: 1800, rating: 7.0)),
            Player(id: "new02", name: "Sven Botman", number: 4, position: .def, nationality: "Netherlands", age: 25, stats: PlayerStats(appearances: 24, goals: 1, assists: 0, yellowCards: 3, redCards: 0, minutesPlayed: 2100, rating: 7.1)),
            Player(id: "new03", name: "Bruno Guimaraes", number: 39, position: .mid, nationality: "Brazil", age: 27, stats: PlayerStats(appearances: 31, goals: 5, assists: 6, yellowCards: 5, redCards: 0, minutesPlayed: 2700, rating: 7.4)),
            Player(id: "new04", name: "Alexander Isak", number: 14, position: .fwd, nationality: "Sweden", age: 26, stats: PlayerStats(appearances: 30, goals: 19, assists: 4, yellowCards: 1, redCards: 0, minutesPlayed: 2500, rating: 7.8)),
            Player(id: "new05", name: "Anthony Gordon", number: 10, position: .fwd, nationality: "England", age: 24, stats: PlayerStats(appearances: 29, goals: 8, assists: 7, yellowCards: 3, redCards: 0, minutesPlayed: 2400, rating: 7.2)),
        ]),
        Team(id: "avl", name: "Aston Villa", shortName: "Aston Villa", city: "Birmingham", country: "England", stadium: "Villa Park", capacity: 42657, founded: 1874, coach: "Unai Emery", league: "epl", rating: 4.3, icon: "shield.fill", color: Color(hex: 0x670E36), players: [
            Player(id: "avl01", name: "Emiliano Martinez", number: 1, position: .gk, nationality: "Argentina", age: 32, stats: PlayerStats(appearances: 31, goals: 0, assists: 0, yellowCards: 2, redCards: 0, minutesPlayed: 2790, rating: 7.2)),
            Player(id: "avl02", name: "Pau Torres", number: 14, position: .def, nationality: "Spain", age: 28, stats: PlayerStats(appearances: 28, goals: 2, assists: 1, yellowCards: 4, redCards: 0, minutesPlayed: 2450, rating: 7.1)),
            Player(id: "avl03", name: "Youri Tielemans", number: 8, position: .mid, nationality: "Belgium", age: 28, stats: PlayerStats(appearances: 30, goals: 4, assists: 5, yellowCards: 6, redCards: 0, minutesPlayed: 2600, rating: 7.0)),
            Player(id: "avl04", name: "Moussa Diaby", number: 19, position: .fwd, nationality: "France", age: 26, stats: PlayerStats(appearances: 28, goals: 7, assists: 6, yellowCards: 1, redCards: 0, minutesPlayed: 2100, rating: 7.0)),
            Player(id: "avl05", name: "Ollie Watkins", number: 11, position: .fwd, nationality: "England", age: 29, stats: PlayerStats(appearances: 31, goals: 15, assists: 8, yellowCards: 2, redCards: 0, minutesPlayed: 2650, rating: 7.5)),
        ]),
    ]

    static let eplStandings: [Standing] = [
        Standing(id: "epl1", position: 1, teamId: "liv", teamName: "Liverpool", played: 32, won: 22, drawn: 6, lost: 4, goalsFor: 68, goalsAgainst: 28, points: 72, form: [.win, .win, .draw, .win, .loss]),
        Standing(id: "epl2", position: 2, teamId: "ars", teamName: "Arsenal", played: 32, won: 21, drawn: 7, lost: 4, goalsFor: 65, goalsAgainst: 25, points: 70, form: [.win, .win, .win, .draw, .win]),
        Standing(id: "epl3", position: 3, teamId: "mci", teamName: "Man City", played: 32, won: 20, drawn: 5, lost: 7, goalsFor: 72, goalsAgainst: 35, points: 65, form: [.win, .loss, .win, .win, .draw]),
        Standing(id: "epl4", position: 4, teamId: "new", teamName: "Newcastle", played: 32, won: 18, drawn: 6, lost: 8, goalsFor: 55, goalsAgainst: 32, points: 60, form: [.win, .win, .loss, .win, .win]),
        Standing(id: "epl5", position: 5, teamId: "che", teamName: "Chelsea", played: 32, won: 16, drawn: 8, lost: 8, goalsFor: 56, goalsAgainst: 38, points: 56, form: [.draw, .win, .win, .loss, .win]),
        Standing(id: "epl6", position: 6, teamId: "avl", teamName: "Aston Villa", played: 32, won: 16, drawn: 6, lost: 10, goalsFor: 52, goalsAgainst: 40, points: 54, form: [.loss, .win, .draw, .win, .win]),
        Standing(id: "epl7", position: 7, teamId: "tot", teamName: "Tottenham", played: 32, won: 14, drawn: 7, lost: 11, goalsFor: 58, goalsAgainst: 50, points: 49, form: [.win, .loss, .loss, .win, .draw]),
        Standing(id: "epl8", position: 8, teamId: "mun", teamName: "Man Utd", played: 32, won: 12, drawn: 8, lost: 12, goalsFor: 42, goalsAgainst: 44, points: 44, form: [.loss, .draw, .win, .loss, .win]),
    ]

    // MARK: - La Liga 2025/26

    static let laLiga = League(
        id: "laliga", name: "La Liga", country: "Spain", icon: "sun.max.fill",
        color: Color(hex: 0xFF4B44),
        teams: [
            Team(id: "rma", name: "Real Madrid", shortName: "Real Madrid", city: "Madrid", country: "Spain", stadium: "Santiago Bernabeu", capacity: 83186, founded: 1902, coach: "Carlo Ancelotti", league: "laliga", rating: 4.9, icon: "crown.fill", color: Color(hex: 0xFEBE10), players: [
                Player(id: "rma01", name: "Thibaut Courtois", number: 1, position: .gk, nationality: "Belgium", age: 33, stats: PlayerStats(appearances: 28, goals: 0, assists: 0, yellowCards: 1, redCards: 0, minutesPlayed: 2520, rating: 7.4)),
                Player(id: "rma02", name: "Antonio Rudiger", number: 22, position: .def, nationality: "Germany", age: 32, stats: PlayerStats(appearances: 29, goals: 3, assists: 0, yellowCards: 6, redCards: 0, minutesPlayed: 2550, rating: 7.2)),
                Player(id: "rma03", name: "Jude Bellingham", number: 5, position: .mid, nationality: "England", age: 22, stats: PlayerStats(appearances: 30, goals: 12, assists: 8, yellowCards: 4, redCards: 0, minutesPlayed: 2550, rating: 7.8)),
                Player(id: "rma04", name: "Luka Modric", number: 10, position: .mid, nationality: "Croatia", age: 40, stats: PlayerStats(appearances: 22, goals: 2, assists: 5, yellowCards: 3, redCards: 0, minutesPlayed: 1500, rating: 7.1)),
                Player(id: "rma05", name: "Vinicius Junior", number: 7, position: .fwd, nationality: "Brazil", age: 25, stats: PlayerStats(appearances: 29, goals: 16, assists: 9, yellowCards: 5, redCards: 1, minutesPlayed: 2400, rating: 8.0)),
                Player(id: "rma06", name: "Kylian Mbappe", number: 9, position: .fwd, nationality: "France", age: 27, stats: PlayerStats(appearances: 31, goals: 22, assists: 6, yellowCards: 2, redCards: 0, minutesPlayed: 2700, rating: 8.3)),
            ]),
            Team(id: "fcb", name: "FC Barcelona", shortName: "Barcelona", city: "Barcelona", country: "Spain", stadium: "Spotify Camp Nou", capacity: 99354, founded: 1899, coach: "Hansi Flick", league: "laliga", rating: 4.8, icon: "shield.fill", color: Color(hex: 0xA50044), players: [
                Player(id: "fcb01", name: "Marc-Andre ter Stegen", number: 1, position: .gk, nationality: "Germany", age: 33, stats: PlayerStats(appearances: 18, goals: 0, assists: 0, yellowCards: 0, redCards: 0, minutesPlayed: 1620, rating: 7.0)),
                Player(id: "fcb02", name: "Ronald Araujo", number: 4, position: .def, nationality: "Uruguay", age: 26, stats: PlayerStats(appearances: 20, goals: 1, assists: 0, yellowCards: 4, redCards: 0, minutesPlayed: 1750, rating: 7.2)),
                Player(id: "fcb03", name: "Pedri", number: 8, position: .mid, nationality: "Spain", age: 23, stats: PlayerStats(appearances: 28, goals: 5, assists: 8, yellowCards: 3, redCards: 0, minutesPlayed: 2300, rating: 7.6)),
                Player(id: "fcb04", name: "Gavi", number: 6, position: .mid, nationality: "Spain", age: 21, stats: PlayerStats(appearances: 25, goals: 3, assists: 4, yellowCards: 5, redCards: 0, minutesPlayed: 1900, rating: 7.2)),
                Player(id: "fcb05", name: "Lamine Yamal", number: 19, position: .fwd, nationality: "Spain", age: 18, stats: PlayerStats(appearances: 30, goals: 11, assists: 12, yellowCards: 1, redCards: 0, minutesPlayed: 2500, rating: 8.1)),
                Player(id: "fcb06", name: "Robert Lewandowski", number: 9, position: .fwd, nationality: "Poland", age: 37, stats: PlayerStats(appearances: 31, goals: 19, assists: 5, yellowCards: 2, redCards: 0, minutesPlayed: 2600, rating: 7.7)),
            ]),
        ],
        standings: [
            Standing(id: "ll1", position: 1, teamId: "fcb", teamName: "Barcelona", played: 31, won: 23, drawn: 4, lost: 4, goalsFor: 74, goalsAgainst: 30, points: 73, form: [.win, .win, .win, .loss, .win]),
            Standing(id: "ll2", position: 2, teamId: "rma", teamName: "Real Madrid", played: 31, won: 22, drawn: 5, lost: 4, goalsFor: 70, goalsAgainst: 28, points: 71, form: [.win, .draw, .win, .win, .win]),
        ]
    )

    // MARK: - Serie A 2025/26

    static let serieA = League(
        id: "seriea", name: "Serie A", country: "Italy", icon: "building.columns.fill",
        color: Color(hex: 0x008FD7),
        teams: [
            Team(id: "int", name: "Inter Milan", shortName: "Inter", city: "Milan", country: "Italy", stadium: "San Siro", capacity: 75923, founded: 1908, coach: "Simone Inzaghi", league: "seriea", rating: 4.7, icon: "shield.fill", color: Color(hex: 0x0068A8), players: [
                Player(id: "int01", name: "Yann Sommer", number: 1, position: .gk, nationality: "Switzerland", age: 36, stats: PlayerStats(appearances: 30, goals: 0, assists: 0, yellowCards: 1, redCards: 0, minutesPlayed: 2700, rating: 7.1)),
                Player(id: "int02", name: "Alessandro Bastoni", number: 95, position: .def, nationality: "Italy", age: 26, stats: PlayerStats(appearances: 29, goals: 2, assists: 4, yellowCards: 5, redCards: 0, minutesPlayed: 2550, rating: 7.3)),
                Player(id: "int03", name: "Nicolo Barella", number: 23, position: .mid, nationality: "Italy", age: 28, stats: PlayerStats(appearances: 30, goals: 5, assists: 9, yellowCards: 4, redCards: 0, minutesPlayed: 2600, rating: 7.6)),
                Player(id: "int04", name: "Hakan Calhanoglu", number: 20, position: .mid, nationality: "Turkey", age: 31, stats: PlayerStats(appearances: 27, goals: 8, assists: 5, yellowCards: 3, redCards: 0, minutesPlayed: 2300, rating: 7.4)),
                Player(id: "int05", name: "Lautaro Martinez", number: 10, position: .fwd, nationality: "Argentina", age: 28, stats: PlayerStats(appearances: 31, goals: 18, assists: 4, yellowCards: 3, redCards: 0, minutesPlayed: 2600, rating: 7.7)),
                Player(id: "int06", name: "Marcus Thuram", number: 9, position: .fwd, nationality: "France", age: 28, stats: PlayerStats(appearances: 30, goals: 14, assists: 6, yellowCards: 2, redCards: 0, minutesPlayed: 2400, rating: 7.4)),
            ]),
            Team(id: "nap", name: "SSC Napoli", shortName: "Napoli", city: "Naples", country: "Italy", stadium: "Diego Armando Maradona", capacity: 54726, founded: 1926, coach: "Antonio Conte", league: "seriea", rating: 4.5, icon: "shield.fill", color: Color(hex: 0x12A0D7), players: [
                Player(id: "nap01", name: "Alex Meret", number: 1, position: .gk, nationality: "Italy", age: 28, stats: PlayerStats(appearances: 29, goals: 0, assists: 0, yellowCards: 1, redCards: 0, minutesPlayed: 2610, rating: 7.0)),
                Player(id: "nap02", name: "Khvicha Kvaratskhelia", number: 77, position: .fwd, nationality: "Georgia", age: 24, stats: PlayerStats(appearances: 28, goals: 10, assists: 8, yellowCards: 2, redCards: 0, minutesPlayed: 2300, rating: 7.5)),
                Player(id: "nap03", name: "Victor Osimhen", number: 9, position: .fwd, nationality: "Nigeria", age: 26, stats: PlayerStats(appearances: 25, goals: 16, assists: 3, yellowCards: 3, redCards: 0, minutesPlayed: 2100, rating: 7.6)),
            ]),
        ],
        standings: [
            Standing(id: "sa1", position: 1, teamId: "nap", teamName: "Napoli", played: 31, won: 21, drawn: 5, lost: 5, goalsFor: 58, goalsAgainst: 24, points: 68, form: [.win, .win, .draw, .win, .win]),
            Standing(id: "sa2", position: 2, teamId: "int", teamName: "Inter", played: 31, won: 20, drawn: 7, lost: 4, goalsFor: 65, goalsAgainst: 28, points: 67, form: [.win, .draw, .win, .win, .draw]),
        ]
    )

    // MARK: - Bundesliga 2025/26

    static let bundesliga = League(
        id: "buli", name: "Bundesliga", country: "Germany", icon: "flag.fill",
        color: Color(hex: 0xE2001A),
        teams: [
            Team(id: "bay", name: "Bayern Munich", shortName: "Bayern", city: "Munich", country: "Germany", stadium: "Allianz Arena", capacity: 75024, founded: 1900, coach: "Vincent Kompany", league: "buli", rating: 4.8, icon: "star.fill", color: Color(hex: 0xDC052D), players: [
                Player(id: "bay01", name: "Manuel Neuer", number: 1, position: .gk, nationality: "Germany", age: 39, stats: PlayerStats(appearances: 25, goals: 0, assists: 0, yellowCards: 1, redCards: 0, minutesPlayed: 2250, rating: 7.0)),
                Player(id: "bay02", name: "Joshua Kimmich", number: 6, position: .mid, nationality: "Germany", age: 30, stats: PlayerStats(appearances: 31, goals: 3, assists: 10, yellowCards: 6, redCards: 0, minutesPlayed: 2750, rating: 7.5)),
                Player(id: "bay03", name: "Jamal Musiala", number: 42, position: .mid, nationality: "Germany", age: 22, stats: PlayerStats(appearances: 30, goals: 14, assists: 8, yellowCards: 1, redCards: 0, minutesPlayed: 2500, rating: 8.0)),
                Player(id: "bay04", name: "Harry Kane", number: 9, position: .fwd, nationality: "England", age: 32, stats: PlayerStats(appearances: 31, goals: 30, assists: 7, yellowCards: 2, redCards: 0, minutesPlayed: 2750, rating: 8.5)),
            ]),
            Team(id: "lev", name: "Bayer Leverkusen", shortName: "Leverkusen", city: "Leverkusen", country: "Germany", stadium: "BayArena", capacity: 30210, founded: 1904, coach: "Xabi Alonso", league: "buli", rating: 4.6, icon: "shield.fill", color: Color(hex: 0xE32221), players: [
                Player(id: "lev01", name: "Lukas Hradecky", number: 1, position: .gk, nationality: "Finland", age: 35, stats: PlayerStats(appearances: 29, goals: 0, assists: 0, yellowCards: 2, redCards: 0, minutesPlayed: 2610, rating: 7.1)),
                Player(id: "lev02", name: "Florian Wirtz", number: 10, position: .mid, nationality: "Germany", age: 22, stats: PlayerStats(appearances: 30, goals: 12, assists: 11, yellowCards: 2, redCards: 0, minutesPlayed: 2550, rating: 8.1)),
                Player(id: "lev03", name: "Granit Xhaka", number: 34, position: .mid, nationality: "Switzerland", age: 32, stats: PlayerStats(appearances: 31, goals: 3, assists: 6, yellowCards: 5, redCards: 0, minutesPlayed: 2700, rating: 7.3)),
                Player(id: "lev04", name: "Victor Boniface", number: 9, position: .fwd, nationality: "Nigeria", age: 24, stats: PlayerStats(appearances: 26, goals: 14, assists: 4, yellowCards: 2, redCards: 0, minutesPlayed: 2100, rating: 7.5)),
            ]),
        ],
        standings: [
            Standing(id: "bu1", position: 1, teamId: "bay", teamName: "Bayern", played: 30, won: 22, drawn: 4, lost: 4, goalsFor: 80, goalsAgainst: 32, points: 70, form: [.win, .win, .win, .draw, .win]),
            Standing(id: "bu2", position: 2, teamId: "lev", teamName: "Leverkusen", played: 30, won: 20, drawn: 6, lost: 4, goalsFor: 68, goalsAgainst: 30, points: 66, form: [.win, .draw, .win, .win, .win]),
        ]
    )

    // MARK: - Ligue 1 2025/26

    static let ligue1 = League(
        id: "l1", name: "Ligue 1", country: "France", icon: "laurel.leading",
        color: Color(hex: 0xDCE317),
        teams: [
            Team(id: "psg", name: "Paris Saint-Germain", shortName: "PSG", city: "Paris", country: "France", stadium: "Parc des Princes", capacity: 47929, founded: 1970, coach: "Luis Enrique", league: "l1", rating: 4.7, icon: "shield.fill", color: Color(hex: 0x004170), players: [
                Player(id: "psg01", name: "Gianluigi Donnarumma", number: 99, position: .gk, nationality: "Italy", age: 26, stats: PlayerStats(appearances: 29, goals: 0, assists: 0, yellowCards: 1, redCards: 0, minutesPlayed: 2610, rating: 7.0)),
                Player(id: "psg02", name: "Marquinhos", number: 5, position: .def, nationality: "Brazil", age: 31, stats: PlayerStats(appearances: 28, goals: 2, assists: 1, yellowCards: 4, redCards: 0, minutesPlayed: 2450, rating: 7.2)),
                Player(id: "psg03", name: "Vitinha", number: 17, position: .mid, nationality: "Portugal", age: 25, stats: PlayerStats(appearances: 30, goals: 6, assists: 7, yellowCards: 3, redCards: 0, minutesPlayed: 2550, rating: 7.4)),
                Player(id: "psg04", name: "Ousmane Dembele", number: 10, position: .fwd, nationality: "France", age: 28, stats: PlayerStats(appearances: 29, goals: 12, assists: 10, yellowCards: 2, redCards: 0, minutesPlayed: 2300, rating: 7.6)),
                Player(id: "psg05", name: "Bradley Barcola", number: 29, position: .fwd, nationality: "France", age: 23, stats: PlayerStats(appearances: 30, goals: 15, assists: 5, yellowCards: 1, redCards: 0, minutesPlayed: 2400, rating: 7.5)),
            ]),
        ],
        standings: [
            Standing(id: "l11", position: 1, teamId: "psg", teamName: "PSG", played: 30, won: 24, drawn: 3, lost: 3, goalsFor: 70, goalsAgainst: 22, points: 75, form: [.win, .win, .win, .win, .draw]),
        ]
    )

    // MARK: - Champions League 2025/26

    static let championsLeague = League(
        id: "ucl", name: "Champions League", country: "Europe", icon: "trophy.fill",
        color: Color(hex: 0x003399),
        teams: [],
        standings: []
    )

    // MARK: - Matches

    static let matches: [Match] = {
        let cal = Calendar.current
        func d(_ days: Int, h: Int, m: Int) -> Date {
            var c = cal.dateComponents([.year, .month, .day], from: Date())
            c.day! += days
            c.hour = h; c.minute = m; c.second = 0
            return cal.date(from: c)!
        }
        return [
            Match(id: "m1", homeTeam: "Liverpool", awayTeam: "Arsenal", homeScore: 2, awayScore: 2, date: d(-14, h: 17, m: 30), league: "Premier League", venue: "Anfield", round: "Matchday 28"),
            Match(id: "m2", homeTeam: "Man City", awayTeam: "Chelsea", homeScore: 3, awayScore: 1, date: d(-12, h: 15, m: 0), league: "Premier League", venue: "Etihad Stadium", round: "Matchday 28"),
            Match(id: "m3", homeTeam: "Real Madrid", awayTeam: "Barcelona", homeScore: 2, awayScore: 3, date: d(-10, h: 21, m: 0), league: "La Liga", venue: "Santiago Bernabeu", round: "El Clasico"),
            Match(id: "m4", homeTeam: "Inter", awayTeam: "Napoli", homeScore: 1, awayScore: 1, date: d(-9, h: 20, m: 45), league: "Serie A", venue: "San Siro", round: "Matchday 28"),
            Match(id: "m5", homeTeam: "Bayern", awayTeam: "Leverkusen", homeScore: 4, awayScore: 2, date: d(-8, h: 18, m: 30), league: "Bundesliga", venue: "Allianz Arena", round: "Der Klassiker"),
            Match(id: "m6", homeTeam: "PSG", awayTeam: "Monaco", homeScore: 3, awayScore: 0, date: d(-7, h: 21, m: 0), league: "Ligue 1", venue: "Parc des Princes", round: "Matchday 28"),
            Match(id: "m7", homeTeam: "Man Utd", awayTeam: "Tottenham", homeScore: 1, awayScore: 2, date: d(-6, h: 15, m: 0), league: "Premier League", venue: "Old Trafford", round: "Matchday 29"),
            Match(id: "m8", homeTeam: "Newcastle", awayTeam: "Aston Villa", homeScore: 3, awayScore: 1, date: d(-5, h: 20, m: 0), league: "Premier League", venue: "St. James' Park", round: "Matchday 29"),
            Match(id: "m9", homeTeam: "Arsenal", awayTeam: "Man City", homeScore: 1, awayScore: 0, date: d(-3, h: 17, m: 30), league: "Premier League", venue: "Emirates Stadium", round: "Matchday 30"),
            Match(id: "m10", homeTeam: "Liverpool", awayTeam: "Newcastle", homeScore: 2, awayScore: 0, date: d(-2, h: 15, m: 0), league: "Premier League", venue: "Anfield", round: "Matchday 30"),
            Match(id: "m11", homeTeam: "Chelsea", awayTeam: "Tottenham", homeScore: 2, awayScore: 2, date: d(-1, h: 14, m: 0), league: "Premier League", venue: "Stamford Bridge", round: "Matchday 30"),

            Match(id: "m12", homeTeam: "Real Madrid", awayTeam: "Bayern", homeScore: nil, awayScore: nil, date: d(1, h: 21, m: 0), league: "Champions League", venue: "Santiago Bernabeu", round: "QF 1st leg"),
            Match(id: "m13", homeTeam: "Arsenal", awayTeam: "Liverpool", homeScore: nil, awayScore: nil, date: d(2, h: 17, m: 30), league: "Premier League", venue: "Emirates Stadium", round: "Matchday 31"),
            Match(id: "m14", homeTeam: "Barcelona", awayTeam: "Real Madrid", homeScore: nil, awayScore: nil, date: d(4, h: 21, m: 0), league: "La Liga", venue: "Camp Nou", round: "El Clasico"),
            Match(id: "m15", homeTeam: "Inter", awayTeam: "AC Milan", homeScore: nil, awayScore: nil, date: d(5, h: 20, m: 45), league: "Serie A", venue: "San Siro", round: "Derby della Madonnina"),
            Match(id: "m16", homeTeam: "Man City", awayTeam: "Inter", homeScore: nil, awayScore: nil, date: d(7, h: 21, m: 0), league: "Champions League", venue: "Etihad Stadium", round: "QF 1st leg"),
            Match(id: "m17", homeTeam: "Chelsea", awayTeam: "Man Utd", homeScore: nil, awayScore: nil, date: d(8, h: 15, m: 0), league: "Premier League", venue: "Stamford Bridge", round: "Matchday 32"),
            Match(id: "m18", homeTeam: "Bayern", awayTeam: "Real Madrid", homeScore: nil, awayScore: nil, date: d(9, h: 21, m: 0), league: "Champions League", venue: "Allianz Arena", round: "QF 2nd leg"),
            Match(id: "m19", homeTeam: "Liverpool", awayTeam: "Chelsea", homeScore: nil, awayScore: nil, date: d(11, h: 20, m: 0), league: "Premier League", venue: "Anfield", round: "Matchday 32"),
            Match(id: "m20", homeTeam: "Newcastle", awayTeam: "Arsenal", homeScore: nil, awayScore: nil, date: d(14, h: 17, m: 30), league: "Premier League", venue: "St. James' Park", round: "Matchday 33"),
        ]
    }()

    static var upcomingMatches: [Match] { matches.filter { !$0.isPlayed }.sorted { $0.date < $1.date } }
    static var recentResults: [Match] { matches.filter { $0.isPlayed }.sorted { $0.date > $1.date } }
}
