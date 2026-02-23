//
//  beesheetsiOSApp.swift
//  beesheetsiOS
//
//  Created by user275733 on 2/13/26.
//

import SwiftUI
import SwiftData

@main
struct beesheetsiOSApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            // Dependency wiring: choose Mock or API service
            #if DEBUG
            let service: DashboardServiceProtocol = MockDashboardService()
            let viewModel = DashboardViewModel(service: service)
            DashboardView(viewModel: viewModel)
            #else
            let apiClient = APIClient(baseURL: EnvironmentConfig.apiBaseURL, authTokenProvider: { nil })
            let context = DashboardContext(userId: "", tenantId: "", month: Calendar.current.component(.month, from: Date()), year: Calendar.current.component(.year, from: Date()))
            let service: DashboardServiceProtocol = DashboardAPIService(apiClient: apiClient, context: context)
            let viewModel = DashboardViewModel(service: service)
            DashboardView(viewModel: viewModel)
            #endif
        }
        .modelContainer(sharedModelContainer)
    }
}
