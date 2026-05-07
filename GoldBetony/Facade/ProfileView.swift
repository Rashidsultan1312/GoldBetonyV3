import SwiftUI
import PhotosUI

struct ProfileView: View {
    @AppStorage("userName") private var userName = ""
    @AppStorage("userAvatar") private var avatarData: Data?
    @State private var pickerItem: PhotosPickerItem?

    private var avatarImage: Image? {
        guard let data = avatarData, let ui = UIImage(data: data) else { return nil }
        return Image(uiImage: ui)
    }

    private var appVersion: String {
        let v = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let b = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(v) (\(b))"
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    avatarSection
                    nameField
                    infoCards
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
            .background(GB.bg.ignoresSafeArea())
            .navigationTitle("Profile")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationBarTitleDisplayMode(.large)
        }
    }

    // MARK: - Avatar

    private var avatarSection: some View {
        PhotosPicker(selection: $pickerItem, matching: .images) {
            if let avatarImage {
                avatarImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(GB.purple, lineWidth: 2))
            } else {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [GB.purple, GB.purpleLight],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            )
                        )
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(.white.opacity(0.8))
                }
                .frame(width: 100, height: 100)
            }
        }
        .onChange(of: pickerItem) { newItem in
            Task {
                guard let newItem,
                      let data = try? await newItem.loadTransferable(type: Data.self),
                      let ui = UIImage(data: data),
                      let jpeg = ui.jpegData(compressionQuality: 0.7)
                else { return }
                avatarData = jpeg
            }
        }
    }

    // MARK: - Name

    private var nameField: some View {
        TextField("Your name", text: $userName)
            .font(.gbH2)
            .foregroundStyle(GB.text)
            .multilineTextAlignment(.center)
            .padding(.vertical, 8)
            .tint(GB.accent)
    }

    // MARK: - Info Cards

    private var infoCards: some View {
        VStack(spacing: 12) {
            profileRow(icon: "info.circle.fill", title: "Version", value: appVersion)

            Button {
                guard let url = URL(string: "mailto:mykser9204@icloud.com") else { return }
                UIApplication.shared.open(url)
            } label: {
                profileRowContent(icon: "envelope.fill", title: "Support", value: "mykser9204@icloud.com")
            }

            NavigationLink {
                PrivacyPolicyView()
            } label: {
                profileRowContent(icon: "shield.lefthalf.filled", title: "Privacy Policy", value: nil, showChevron: true)
            }
        }
    }

    private func profileRow(icon: String, title: String, value: String) -> some View {
        profileRowContent(icon: icon, title: title, value: value)
    }

    private func profileRowContent(icon: String, title: String, value: String?, showChevron: Bool = false) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(GB.accent)
                .frame(width: 28)

            Text(title)
                .font(.gbBody)
                .foregroundStyle(GB.text)

            Spacer()

            if let value {
                Text(value)
                    .font(.gbCaption)
                    .foregroundStyle(GB.textSecondary)
            }

            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(GB.textMuted)
            }
        }
        .padding(16)
        .gbCard()
    }
}
