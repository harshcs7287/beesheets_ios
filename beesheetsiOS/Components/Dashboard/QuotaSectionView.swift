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
        VStack(alignment: .leading, spacing: 8) {
            Text("Your Quota")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(leaveQuotas) { quota in
                        quotaCard(for: quota.displayName, entitled: quota.daysEntitled, availed: quota.daysAvailed)
                    }

                    if let wfh = wfhQuota {
                        quotaCard(for: "WFH", entitled: wfh.daysEntitled, availed: wfh.daysAvailed)
                    }
                }
            }
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(12)
    }

    @ViewBuilder
    private func quotaCard(for title: String, entitled: Double, availed: Double) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(String(format: "Entitled: %.1f", entitled))
                .font(.headline)
            Text(String(format: "Availed: %.1f", availed))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(width: 150)
        .background(Color(.systemBackground).opacity(0.6))
        .cornerRadius(8)
        .shadow(radius: 1)
    }
}
