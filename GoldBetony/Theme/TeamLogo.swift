import SwiftUI

enum TeamLogos {
    static let urls: [String: String] = [
        "Manchester City": "https://crests.football-data.org/65.png",
        "Man City": "https://crests.football-data.org/65.png",
        "Arsenal": "https://crests.football-data.org/57.png",
        "Liverpool": "https://crests.football-data.org/64.png",
        "Chelsea": "https://crests.football-data.org/61.png",
        "Manchester United": "https://crests.football-data.org/66.png",
        "Man Utd": "https://crests.football-data.org/66.png",
        "Tottenham Hotspur": "https://crests.football-data.org/73.png",
        "Tottenham": "https://crests.football-data.org/73.png",
        "Newcastle United": "https://crests.football-data.org/67.png",
        "Newcastle": "https://crests.football-data.org/67.png",
        "Aston Villa": "https://crests.football-data.org/58.png",
        "Real Madrid": "https://crests.football-data.org/86.png",
        "FC Barcelona": "https://crests.football-data.org/81.png",
        "Barcelona": "https://crests.football-data.org/81.png",
        "Atletico Madrid": "https://crests.football-data.org/78.png",
        "Atletico": "https://crests.football-data.org/78.png",
        "Inter Milan": "https://crests.football-data.org/108.png",
        "Inter": "https://crests.football-data.org/108.png",
        "SSC Napoli": "https://crests.football-data.org/113.png",
        "Napoli": "https://crests.football-data.org/113.png",
        "AC Milan": "https://crests.football-data.org/98.png",
        "Juventus": "https://crests.football-data.org/109.png",
        "AS Roma": "https://crests.football-data.org/100.png",
        "Roma": "https://crests.football-data.org/100.png",
        "SS Lazio": "https://crests.football-data.org/110.png",
        "Lazio": "https://crests.football-data.org/110.png",
        "Bayern Munich": "https://crests.football-data.org/5.png",
        "Bayern": "https://crests.football-data.org/5.png",
        "Bayer Leverkusen": "https://crests.football-data.org/3.png",
        "Leverkusen": "https://crests.football-data.org/3.png",
        "Borussia Dortmund": "https://crests.football-data.org/4.png",
        "Dortmund": "https://crests.football-data.org/4.png",
        "RB Leipzig": "https://crests.football-data.org/721.png",
        "Leipzig": "https://crests.football-data.org/721.png",
        "VfB Stuttgart": "https://crests.football-data.org/10.png",
        "Stuttgart": "https://crests.football-data.org/10.png",
        "Eintracht Frankfurt": "https://crests.football-data.org/19.png",
        "Frankfurt": "https://crests.football-data.org/19.png",
        "Paris Saint-Germain": "https://crests.football-data.org/524.png",
        "PSG": "https://crests.football-data.org/524.png",
        "Olympique Marseille": "https://crests.football-data.org/516.png",
        "Marseille": "https://crests.football-data.org/516.png",
        "AS Monaco": "https://crests.football-data.org/548.png",
        "Monaco": "https://crests.football-data.org/548.png",
        "Olympique Lyon": "https://crests.football-data.org/523.png",
        "Lyon": "https://crests.football-data.org/523.png",
        "LOSC Lille": "https://crests.football-data.org/521.png",
        "Lille": "https://crests.football-data.org/521.png",
    ]

    static func url(for name: String) -> URL? {
        guard let str = urls[name] else { return nil }
        return URL(string: str)
    }
}

struct TeamLogo: View {
    let name: String
    var size: CGFloat = 38

    var body: some View {
        if let url = TeamLogos.url(for: name) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let img):
                    img.resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                case .failure:
                    fallbackBadge
                case .empty:
                    ProgressView()
                        .frame(width: size, height: size)
                @unknown default:
                    fallbackBadge
                }
            }
        } else {
            fallbackBadge
        }
    }

    private var fallbackBadge: some View {
        TeamBadge(name: name, size: size)
    }
}

struct TeamLogoFromModel: View {
    let team: Team
    var size: CGFloat = 38

    var body: some View {
        TeamLogo(name: team.name, size: size)
    }
}
