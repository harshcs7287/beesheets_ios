import Foundation

/// Context holding runtime parameters needed to build dashboard API requests.
public struct DashboardContext {
    public let userId: String
    public let tenantId: String
    public let month: Int
    public let year: Int

    public init(userId: String, tenantId: String, month: Int, year: Int) {
        self.userId = userId
        self.tenantId = tenantId
        self.month = month
        self.year = year
    }
}

/// API-backed implementation of `DashboardServiceProtocol`.
public struct DashboardAPIService: DashboardServiceProtocol {
    private let apiClient: APIClient
    private let context: DashboardContext

    public init(apiClient: APIClient, context: DashboardContext) {
        self.apiClient = apiClient
        self.context = context
    }

    public func fetchDashboardHome() async throws -> DashboardHomeDTO {
        // Prepare date string for today's summary
        let todayISO = ISO8601DateFormatter().string(from: Date())

        // Create endpoints
        let userEndpoint = DashboardEndpoints.userDetails(userId: context.userId)
        let leaveEndpoint = DashboardEndpoints.leaveQuota(userId: context.userId, tenantId: context.tenantId)
        let wfhEndpoint = DashboardEndpoints.wfhSummary(userId: context.userId, month: context.month, year: context.year, tenantId: context.tenantId)
        let todayEndpoint = DashboardEndpoints.todaySummary(userId: context.userId, dateISO: todayISO)
        let payrollEndpoint = DashboardEndpoints.workPayroll(userId: context.userId, month: context.month, year: context.year, tenantId: context.tenantId)
        let quickLinksEndpoint = DashboardEndpoints.quickLinks(userId: context.userId, tenantId: context.tenantId)

        // Perform requests in parallel
        async let userReq = apiClient.request(userEndpoint, as: DashboardUserDTO.self)
        async let leaveReq = apiClient.request(leaveEndpoint, as: [LeaveQuotaDTO].self)
        async let wfhReq = apiClient.request(wfhEndpoint, as: WFHQuotaDTO.self)
        async let todayReq = apiClient.request(todayEndpoint, as: TodaySummaryDTO.self)
        async let payrollReq = apiClient.request(payrollEndpoint, as: WorkPayrollDTO.self)
        async let quickLinksReq = apiClient.request(quickLinksEndpoint, as: [QuickLinkDTO].self)

        do {
            let (user, leaveQuotas, wfhQuota, todaySummary, workPayroll, quickLinks) = try await (
                userReq,
                leaveReq,
                wfhReq,
                todayReq,
                payrollReq,
                quickLinksReq
            )

            let home = DashboardHomeDTO(
                user: user,
                todaySummary: todaySummary,
                workPayroll: workPayroll,
                leaveQuotas: leaveQuotas,
                wfhQuota: wfhQuota,
                quickLinks: quickLinks
            )

            return home
        } catch let apiErr as APIError {
            switch apiErr {
            case .serverError(let status, _):
                throw DashboardServiceError.serverError(statusCode: status)
            case .decoding(let underlying):
                throw DashboardServiceError.decodingFailed(underlying: underlying)
            default:
                throw DashboardServiceError.networkUnavailable
            }
        } catch let dashErr as DashboardServiceError {
            throw dashErr
        } catch {
            throw DashboardServiceError.networkUnavailable
        }
    }
}

