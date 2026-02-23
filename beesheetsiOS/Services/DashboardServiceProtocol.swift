import Foundation

public protocol DashboardServiceProtocol {
    func fetchDashboardHome() async throws -> DashboardHomeDTO
}

public enum DashboardServiceError: Error, Equatable {
    public static func == (lhs: DashboardServiceError, rhs: DashboardServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.failedToLoadMockData, .failedToLoadMockData):
            return true
        case (.decodingFailed, .decodingFailed):
            return true
        case (.networkUnavailable, .networkUnavailable):
            return true
        case (.serverError(let lhsCode), .serverError(let rhsCode)):
            return lhsCode == rhsCode
        default:
            return false
        }
    }
    case failedToLoadMockData
    case decodingFailed(underlying: Error)
    case networkUnavailable
    case serverError(statusCode: Int)
}
