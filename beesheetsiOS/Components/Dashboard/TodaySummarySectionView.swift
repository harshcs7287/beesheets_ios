// filepath: Components/Dashboard/TodaySummarySectionView.swift
import SwiftUI

public struct TodaySummarySectionView: View {
    public let summary: TodaySummaryDTO

    public init(summary: TodaySummaryDTO) {
        self.summary = summary
    }

    private func formattedDuration(_ seconds: Int) -> String {
        let hrs = seconds / 3600
        let mins = (seconds % 3600) / 60
        return String(format: "%dh %dm", hrs, mins)
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today")
                .font(.headline)
            HStack {
                VStack(alignment: .leading) {
                    Text("Clocked")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(formattedDuration(summary.clockedSeconds))
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Break")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(formattedDuration(summary.breakSeconds))
                        .font(.title3)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(12)
    }
}
