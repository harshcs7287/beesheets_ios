// filepath: Components/Dashboard/QuotaSectionView.swift
import SwiftUI

public struct QuotaSectionView: View {
    public let leaveQuotas: [LeaveQuotaDTO]
    public let wfhQuota: WFHQuotaDTO?

    public init(leaveQuotas: [LeaveQuotaDTO], wfhQuota: WFHQuotaDTO?) {
        self.leaveQuotas = leaveQuotas
        self.wfhQuota = wfhQuota
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack(spacing: 8) {
                Image(systemName: "chart.bar.doc.horizontal")
                    .foregroundColor(.green)
                Text("Your Quota")
                    .font(.headline)
            }

            VStack(spacing: 12) {
                ForEach(leaveQuotas) { quota in
                    quotaCard(
                        title: quota.displayName,
                        periodLabel: periodLabel(for: quota.periodUnit),
                        iconName: "calendar.badge.plus",
                        entitled: quota.daysEntitled,
                        availed: quota.daysAvailed
                    )
                }

                if let wfh = wfhQuota {
                    quotaCard(
                        title: "WFH Days",
                        periodLabel: periodLabel(for: wfh.periodUnit),
                        iconName: "house",
                        entitled: wfh.daysEntitled,
                        availed: wfh.daysAvailed
                    )
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }

    @ViewBuilder
    private func quotaCard(
        title: String,
        periodLabel: String,
        iconName: String,
        entitled: Double,
        availed: Double
    ) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white,
                            Color.blue.opacity(0.05)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    HStack(spacing: 10) {
                        Image(systemName: iconName)
                            .font(.system(size: 22))
                            .foregroundColor(.blue)
                            .padding(10)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer()

                    Text(periodLabel)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.15))
                        .foregroundColor(.green)
                        .clipShape(Capsule())
                }

                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(entitledDisplay(entitled))
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Text("Entitled")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 4) {
                        Text(entitledDisplay(availed))
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Text("Availed")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 4)
                    .cornerRadius(2)
            }
            .padding(16)
        }
    }

    private func periodLabel(for unit: QuotaPeriodUnit) -> String {
        switch unit {
        case .yearly: return "Yearly"
        case .quarterly: return "Quarterly"
        case .monthly: return "Monthly"
        case .weekly: return "Weekly"
        case .custom: return "Custom"
        }
    }

    private func entitledDisplay(_ value: Double) -> String {
        if value.rounded(.towardZero) == value {
            return String(format: "%.0f", value)
        } else {
            return String(format: "%.1f", value)
        }
    }
}
