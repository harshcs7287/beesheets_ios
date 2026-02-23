// filepath: Views/Dashboard/DashboardView.swift
import SwiftUI

public struct DashboardView: View {
    @StateObject private var viewModel: DashboardViewModel

    public init(viewModel: DashboardViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
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
            .navigationTitle("Dashboard")
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
