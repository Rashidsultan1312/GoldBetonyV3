import SwiftUI

enum GB {
    // GoldBet-style backgrounds
    static let bg = Color(hex: 0x0E1225)
    static let surface = Color(hex: 0x141A2E)
    static let card = Color(hex: 0x1C2442)
    static let cardElevated = Color(hex: 0x243054)

    // GoldBet lime accent — signature color
    static let accent = Color(hex: 0xF4FD2B)
    static let accentDark = Color(hex: 0xC8D420)
    static let onAccent = Color(hex: 0x0E0E0E)

    // Purple — GoldBet secondary
    static let purple = Color(hex: 0x8726FF)
    static let purpleLight = Color(hex: 0xA855F7)
    static let purpleBg = Color(hex: 0x8726FF).opacity(0.12)

    // Match results
    static let win = Color(hex: 0x22C55E)
    static let draw = Color(hex: 0xFBBF24)
    static let loss = Color(hex: 0xEF4444)

    // Text
    static let text = Color(hex: 0xF0F0F0)
    static let textSecondary = Color(hex: 0xA9AABF)
    static let textMuted = Color(hex: 0x5A6180)

    // Borders
    static let border = Color(hex: 0x272F50)
    static let borderHover = Color(hex: 0x2D3864)

    // Sizing
    static let radius: CGFloat = 12
    static let radiusSm: CGFloat = 8
    static let radiusLg: CGFloat = 16

    // GoldBet gradients
    static let cardGrad = LinearGradient(
        colors: [Color(hex: 0x1C2442), Color(hex: 0x161D38)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let heroGrad = LinearGradient(
        colors: [purple.opacity(0.4), Color(hex: 0x0E1225)],
        startPoint: .top, endPoint: .bottom
    )
    static let accentGrad = LinearGradient(
        colors: [Color(hex: 0xF4FD2B), Color(hex: 0xD4E020)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

// MARK: - Card Styles

struct GBCardMod: ViewModifier {
    var elevated: Bool = false
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: GB.radius, style: .continuous)
                    .fill(elevated ? GB.cardElevated : GB.card)
            )
            .overlay(
                RoundedRectangle(cornerRadius: GB.radius, style: .continuous)
                    .stroke(GB.border, lineWidth: 0.5)
            )
            .clipShape(RoundedRectangle(cornerRadius: GB.radius, style: .continuous))
    }
}

struct GBPrimaryButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15, weight: .bold))
            .foregroundStyle(GB.onAccent)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(GB.accentGrad)
            .clipShape(RoundedRectangle(cornerRadius: GB.radiusSm))
    }
}

extension View {
    func gbCard(elevated: Bool = false) -> some View { modifier(GBCardMod(elevated: elevated)) }
    func gbPrimaryButton() -> some View { modifier(GBPrimaryButton()) }
}

// MARK: - Fonts (Raleway-inspired weights)

extension Font {
    static let gbTitle = Font.system(size: 26, weight: .bold)
    static let gbH2 = Font.system(size: 20, weight: .bold)
    static let gbH3 = Font.system(size: 17, weight: .semibold)
    static let gbBody = Font.system(size: 15)
    static let gbCaption = Font.system(size: 12, weight: .medium)
    static let gbScore = Font.system(size: 24, weight: .black, design: .monospaced)
    static let gbMono = Font.system(size: 13, weight: .semibold, design: .monospaced)
}
