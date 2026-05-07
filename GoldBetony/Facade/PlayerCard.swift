import SwiftUI

struct PlayerCard: View {
    let player: Player

    var body: some View {
        HStack(spacing: 12) {
            Text("#\(player.number)")
                .font(.gbMono)
                .foregroundStyle(GB.accent)
                .frame(width: 32, alignment: .center)

            VStack(alignment: .leading, spacing: 2) {
                Text(player.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(GB.text)
                HStack(spacing: 4) {
                    Text(player.nationality)
                    Text("·")
                    Text("\(player.age)")
                }
                .font(.system(size: 11))
                .foregroundStyle(GB.textSecondary)
            }

            Spacer()

            if player.stats.goals > 0 || player.stats.assists > 0 {
                HStack(spacing: 10) {
                    if player.stats.goals > 0 {
                        statBadge("\(player.stats.goals)", "G")
                    }
                    if player.stats.assists > 0 {
                        statBadge("\(player.stats.assists)", "A")
                    }
                }
            }

            ratingBadge(player.stats.rating)

            Image(systemName: "chevron.right")
                .font(.system(size: 10))
                .foregroundStyle(GB.textMuted)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(GB.surface)
        .clipShape(RoundedRectangle(cornerRadius: GB.radiusSm))
        .overlay(
            RoundedRectangle(cornerRadius: GB.radiusSm)
                .stroke(GB.border, lineWidth: 0.5)
        )
    }

    private func statBadge(_ value: String, _ label: String) -> some View {
        VStack(spacing: 1) {
            Text(value)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(GB.text)
            Text(label)
                .font(.system(size: 8, weight: .bold))
                .foregroundStyle(GB.textMuted)
        }
    }

    private func ratingBadge(_ rating: Double) -> some View {
        Text(String(format: "%.1f", rating))
            .font(.system(size: 11, weight: .bold))
            .foregroundStyle(ratingColor(rating))
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background(ratingColor(rating).opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }

    private func ratingColor(_ r: Double) -> Color {
        if r >= 7.5 { return GB.win }
        if r >= 6.5 { return GB.draw }
        return GB.loss
    }
}
