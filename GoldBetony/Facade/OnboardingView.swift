import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var page = 0

    private let pages: [(icon: String, title: String, text: String)] = [
        ("trophy.fill", "Leagues & Tournaments", "Follow top 6 European leagues and Champions League — standings, teams, and stats"),
        ("sportscourt.fill", "Live Matches", "Upcoming fixtures and recent results updated in real time"),
        ("star.fill", "Favorites", "Save your favorite teams for quick access")
    ]

    var body: some View {
        ZStack {
            GB.bg.ignoresSafeArea()
            GB.heroGrad.ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    if page < pages.count - 1 {
                        Button("Skip") {
                            withAnimation { hasSeenOnboarding = true }
                        }
                        .font(.gbBody)
                        .foregroundStyle(GB.textMuted)
                        .padding(.trailing, 24)
                        .padding(.top, 16)
                    }
                }
                .frame(height: 44)

                TabView(selection: $page) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { i, item in
                        VStack(spacing: 24) {
                            Spacer()

                            Image(systemName: item.icon)
                                .font(.system(size: 80))
                                .foregroundStyle(GB.accent)
                                .shadow(color: GB.accent.opacity(0.3), radius: 20)

                            Text(item.title)
                                .font(.gbTitle)
                                .foregroundStyle(GB.text)
                                .multilineTextAlignment(.center)

                            Text(item.text)
                                .font(.gbBody)
                                .foregroundStyle(GB.textSecondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)

                            Spacer()
                            Spacer()
                        }
                        .tag(i)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))

                Button {
                    if page < pages.count - 1 {
                        withAnimation { page += 1 }
                    } else {
                        withAnimation { hasSeenOnboarding = true }
                    }
                } label: {
                    Text(page < pages.count - 1 ? "Next" : "Get Started")
                        .frame(maxWidth: .infinity)
                }
                .gbPrimaryButton()
                .padding(.horizontal, 32)
                .padding(.bottom, 48)
            }
        }
    }
}
