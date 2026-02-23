// filepath: Views/Dashboard/DashboardView.swift
import SwiftUI

public struct DashboardView: View {
    @StateObject private var viewModel: DashboardViewModel
    private let onNotificationsTap: () -> Void
    private let onProfileTap: () -> Void

    public init(
        viewModel: DashboardViewModel,
        onNotificationsTap: @escaping () -> Void = {},
        onProfileTap: @escaping () -> Void = {}
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onNotificationsTap = onNotificationsTap
        self.onProfileTap = onProfileTap
    }

    public var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.error {
                    VStack(spacing: 12) {
                        Text("Failed to load dashboard")
                            .font(.headline)
                        Text(String(describing: error))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Button("Retry") {
                            Task { await viewModel.load() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            GreetingSectionView(name: viewModel.dashboard?.user.fullName ?? "Guest")
                            if let today = viewModel.todaySummary {
                                TodaySummarySectionView(summary: today)
                            }
                            QuotaSectionView(leaveQuotas: viewModel.leaveQuotas, wfhQuota: viewModel.wfhQuota)
                            QuickLinksSectionView(links: viewModel.quickLinks)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 8) {
                        Image("beesheets_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 96, height: 32)
                    }
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: onNotificationsTap) {
                        Image(systemName: "bell")
                            .font(.system(size: 18, weight: .regular))
                    }

                    Button(action: onProfileTap) {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 20, weight: .regular))
                    }
                }
            }
        }
        .task { await viewModel.load() }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        // Use mock service for preview
        let vm = DashboardViewModel(service: MockDashboardService())
        DashboardView(viewModel: vm)
    }
}
