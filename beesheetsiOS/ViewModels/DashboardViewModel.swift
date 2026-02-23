// filepath: ViewModels/DashboardViewModel.swift
import Foundation
import SwiftUI
import Combine

public final class DashboardViewModel: ObservableObject {
    @Published var dashboard: DashboardHomeDTO?
    @Published var isLoading: Bool = false
    @Published var error: DashboardServiceError?

    private let service: DashboardServiceProtocol

    public init(service: DashboardServiceProtocol) {
        self.service = service
    }

    @MainActor
    func load() async {
        isLoading = true
        error = nil

        do {
            let dto = try await service.fetchDashboardHome()
            self.dashboard = dto
        } catch let e as DashboardServiceError {
            self.error = e
        } catch {
            self.error = .networkUnavailable
        }

        isLoading = false
    }

    // MARK: - View helpers
    var greetingTitle: String {
        guard let name = dashboard?.user.fullName else { return "Welcome" }
        return "Good Morning, \(name)"
    }

    var todaySummary: TodaySummaryDTO? { dashboard?.todaySummary }
    var leaveQuotas: [LeaveQuotaDTO] { dashboard?.leaveQuotas ?? [] }
    var wfhQuota: WFHQuotaDTO? { dashboard?.wfhQuota }
    var quickLinks: [QuickLinkDTO] { dashboard?.quickLinks ?? [] }
}
