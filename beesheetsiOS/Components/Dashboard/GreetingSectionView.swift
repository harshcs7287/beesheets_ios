// filepath: Components/Dashboard/GreetingSectionView.swift
import SwiftUI

public struct GreetingSectionView: View {
    public let name: String

    public init(name: String) {
        self.name = name
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.08, green: 0.79, blue: 0.40),
                            Color(red: 0.01, green: 0.49, blue: 0.96)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            HStack(spacing: 16) {
                Image(systemName: "person.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.white.opacity(0.15))
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text("Welcome! \(name)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }

                Spacer()
            }
            .padding(20)
        }
    }
}
