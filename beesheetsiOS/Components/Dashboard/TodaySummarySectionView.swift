// filepath: Components/Dashboard/TodaySummarySectionView.swift
import SwiftUI

public struct TodaySummarySectionView: View {
    public let summary: TodaySummaryDTO

    public init(summary: TodaySummaryDTO) {
        self.summary = summary
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack(spacing: 8) {
                Image(systemName: "calendar")
                    .foregroundColor(Color.green)

                Text("Today's Summary")
                    .font(.headline)
            }

            // Rows
            VStack(spacing: 12) {
                summaryRow(
                    iconName: "calendar.badge.clock",
                    title: "Date",
                    value: formattedDate(summary.date),
                    valueColor: .primary
                )

                summaryRow(
                    iconName: "clock",
                    title: "Clocked Time",
                    value: formattedDuration(summary.clockedSeconds),
                    valueColor: Color.green
                )

                summaryRow(
                    iconName: "pause.circle",
                    title: "Break Time",
                    value: formattedDuration(summary.breakSeconds),
                    valueColor: .secondary
                )
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }

    private func formattedDuration(_ seconds: Int) -> String {
        let hrs = seconds / 3600
        let mins = (seconds % 3600) / 60
        return String(format: "%d hrs %02d min", hrs, mins)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return formatter.string(from: date)
    }

    @ViewBuilder
    private func summaryRow(
        iconName: String,
        title: String,
        value: String,
        valueColor: Color
    ) -> some View {
        HStack {
            HStack(spacing: 8) {
                Image(systemName: iconName)
                    .foregroundColor(.green)
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(valueColor)
        }
    }
}
