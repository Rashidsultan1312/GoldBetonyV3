import SwiftUI

struct ContentView: View {
    @StateObject private var store = SportsStore.shared
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some View {
        WebGateRouter {
            Group {
                if hasSeenOnboarding {
                    FacadeTabView()
                        .environmentObject(store)
                        .task { await store.loadIfNeeded() }
                } else {
                    OnboardingView()
                }
            }
        } webContent: { url in
            WebGateView(url: url)
        }
    }
}
