// filepath: Components/Dashboard/QuickLinksSectionView.swift
import SwiftUI

public struct QuickLinksSectionView: View {
    public let links: [QuickLinkDTO]

    public init(links: [QuickLinkDTO]) {
        self.links = links
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Quick Links")
                .font(.headline)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 12)], spacing: 12) {
                ForEach(links) { link in
                    Link(destination: link.targetURL) {
                        VStack {
                            Image(systemName: link.iconSystemName)
                                .font(.title)
                                .frame(width: 44, height: 44)
                                .background(.ultraThinMaterial)
                                .cornerRadius(8)
                            Text(link.title)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemBackground).opacity(0.6))
                        .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(12)
    }
}
