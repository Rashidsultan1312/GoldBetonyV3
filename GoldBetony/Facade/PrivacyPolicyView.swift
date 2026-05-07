import SwiftUI

struct PrivacyPolicyView: View {
    private let url = URL(string: "https://savealon.quest/policy")!

    var body: some View {
        WebGateView(url: url)
            .navigationTitle("Privacy Policy")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
    }
}
