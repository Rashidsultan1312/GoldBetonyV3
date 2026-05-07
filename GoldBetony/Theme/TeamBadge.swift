import SwiftUI

struct TeamBadge: View {
    let name: String
    var size: CGFloat = 38

    private var initials: String {
        let words = name.split(separator: " ")
        if words.count >= 2 {
            return String(words[0].prefix(1) + words[1].prefix(1)).uppercased()
        }
        return String(name.prefix(3)).uppercased()
    }

    private var badgeColor: Color {
        let colors: [Color] = [
            Color(hex: 0xC8102E), Color(hex: 0x6CADDF), Color(hex: 0xEF0107),
            Color(hex: 0x034694), Color(hex: 0xDA291C), Color(hex: 0x132257),
            Color(hex: 0x241F20), Color(hex: 0x670E36), Color(hex: 0xFEBE10),
            Color(hex: 0xA50044), Color(hex: 0x0068A8), Color(hex: 0x12A0D7),
            Color(hex: 0xDC052D), Color(hex: 0xE32221), Color(hex: 0x004170),
        ]
        let hash = abs(name.hashValue)
        return colors[hash % colors.count]
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [badgeColor, badgeColor.opacity(0.7)],
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                )
                .frame(width: size, height: size)

            Text(initials)
                .font(.system(size: size * 0.34, weight: .black))
                .foregroundStyle(.white)
        }
    }
}

struct TeamBadgeFromModel: View {
    let team: Team
    var size: CGFloat = 38

    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [team.color, team.color.opacity(0.7)],
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                )
                .frame(width: size, height: size)

            Text(initials)
                .font(.system(size: size * 0.34, weight: .black))
                .foregroundStyle(.white)
        }
    }

    private var initials: String {
        let words = team.shortName.split(separator: " ")
        if words.count >= 2 {
            return String(words[0].prefix(1) + words[1].prefix(1)).uppercased()
        }
        return String(team.shortName.prefix(3)).uppercased()
    }
}
