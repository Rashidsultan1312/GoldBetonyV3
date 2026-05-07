import SwiftUI

struct PlayerDetailView: View {
    let player: Player

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                header
                seasonStats
                detailedStats
            }
            .padding(.bottom, 20)
        }
        .background(GB.bg.ignoresSafeArea())
        .navigationTitle(player.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        ZStack {
            LinearGradient(
                colors: [player.position.color.opacity(0.3), GB.bg],
                startPoint: .top, endPoint: .bottom
            )
            .frame(height: 200)

            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(player.position.color.opacity(0.15))
                        .frame(width: 90, height: 90)
                    Text("#\(player.number)")
                        .font(.system(size: 32, weight: .black, design: .monospaced))
                        .foregroundStyle(player.position.color)
                }

                Text(player.name)
                    .font(.gbTitle)
                    .foregroundStyle(GB.text)

                HStack(spacing: 12) {
                    positionBadge
                    Text(player.nationality)
                        .font(.gbCaption)
                        .foregroundStyle(GB.textSecondary)
                    Text("·")
                        .foregroundStyle(GB.textMuted)
                    Text("\(player.age) years")
                        .font(.gbCaption)
                        .foregroundStyle(GB.textSecondary)
                }
            }
        }
    }

    private var positionBadge: some View {
        Text(player.position.label)
            .font(.system(size: 11, weight: .bold))
            .foregroundStyle(player.position.color)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(player.position.color.opacity(0.12))
            .clipShape(Capsule())
    }

    private var seasonStats: some View {
        VStack(spacing: 12) {
            Text("SEASON 2025/26")
                .font(.gbCaption)
                .foregroundStyle(GB.accent)
                .tracking(1.5)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 0) {
                bigStat("\(player.stats.appearances)", "Apps")
                bigStatDivider
                bigStat("\(player.stats.goals)", "Goals")
                bigStatDivider
                bigStat("\(player.stats.assists)", "Assists")
                bigStatDivider
                bigStat(String(format: "%.1f", player.stats.rating), "Rating")
            }
        }
        .padding(16)
        .background(GB.card)
        .clipShape(RoundedRectangle(cornerRadius: GB.radius))
        .overlay(
            RoundedRectangle(cornerRadius: GB.radius)
                .stroke(GB.border, lineWidth: 0.5)
        )
        .padding(.horizontal, 16)
    }

    private func bigStat(_ value: String, _ label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(GB.text)
            Text(label)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(GB.textMuted)
        }
        .frame(maxWidth: .infinity)
    }

    private var bigStatDivider: some View {
        Rectangle().fill(GB.border).frame(width: 0.5, height: 40)
    }

    private var detailedStats: some View {
        VStack(spacing: 10) {
            statRow("Minutes Played", "\(player.stats.minutesPlayed.formatted())", icon: "clock.fill")
            statRow("Yellow Cards", "\(player.stats.yellowCards)", icon: "rectangle.fill", iconColor: .yellow)
            statRow("Red Cards", "\(player.stats.redCards)", icon: "rectangle.fill", iconColor: .red)

            if player.stats.appearances > 0 {
                let goalsPerGame = Double(player.stats.goals) / Double(player.stats.appearances)
                statRow("Goals per Match", String(format: "%.2f", goalsPerGame), icon: "flame.fill")

                let minsPerGoal = player.stats.goals > 0 ? player.stats.minutesPlayed / player.stats.goals : 0
                if minsPerGoal > 0 {
                    statRow("Minutes per Goal", "\(minsPerGoal)", icon: "timer")
                }
            }
        }
        .padding(16)
        .background(GB.card)
        .clipShape(RoundedRectangle(cornerRadius: GB.radius))
        .overlay(
            RoundedRectangle(cornerRadius: GB.radius)
                .stroke(GB.border, lineWidth: 0.5)
        )
        .padding(.horizontal, 16)
    }

    private func statRow(_ label: String, _ value: String, icon: String, iconColor: Color = GB.purple) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundStyle(iconColor)
                .frame(width: 20)
            Text(label)
                .font(.system(size: 13))
                .foregroundStyle(GB.textSecondary)
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(GB.text)
        }
    }
}
