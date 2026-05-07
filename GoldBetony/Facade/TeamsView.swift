import SwiftUI

struct TeamRow: View {
    let team: Team

    var body: some View {
        HStack(spacing: 14) {
            TeamLogoFromModel(team: team, size: 46)

            VStack(alignment: .leading, spacing: 3) {
                Text(team.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(GB.text)
                HStack(spacing: 4) {
                    Text(team.city)
                    Text("·")
                    Text(team.stadium)
                }
                .font(.system(size: 11))
                .foregroundStyle(GB.textSecondary)
                .lineLimit(1)
            }

            Spacer()

            HStack(spacing: 3) {
                Image(systemName: "star.fill")
                    .font(.system(size: 9))
                    .foregroundStyle(GB.accent)
                Text(String(format: "%.1f", team.rating))
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(GB.text)
            }

            Image(systemName: "chevron.right")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(GB.textMuted)
        }
        .padding(14)
        .background(GB.card)
        .clipShape(RoundedRectangle(cornerRadius: GB.radius, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: GB.radius, style: .continuous)
                .stroke(GB.border, lineWidth: 0.5)
        )
    }
}
