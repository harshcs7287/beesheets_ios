// filepath: Networking/DashboardEndpoints.swift
import Foundation

enum DashboardEndpoints {
    // Example paths based on web API patterns. Base URL is provided by EnvironmentConfig.
    static func userDetails(userId: String) -> Endpoint {
        Endpoint(path: "api/v1/users/\(userId)", method: .get)
    }

    static func leaveQuota(userId: String, tenantId: String) -> Endpoint {
        let query = [URLQueryItem(name: "userId", value: userId), URLQueryItem(name: "tenantId", value: tenantId)]
        return Endpoint(path: "api/v1/leaves/quotas", method: .get, queryItems: query)
    }

    static func wfhSummary(userId: String, month: Int, year: Int, tenantId: String) -> Endpoint {
        let query = [
            URLQueryItem(name: "userId", value: userId),
            URLQueryItem(name: "month", value: String(month)),
            URLQueryItem(name: "year", value: String(year)),
            URLQueryItem(name: "tenantId", value: tenantId)
        ]
        return Endpoint(path: "api/v1/wfh/summary", method: .get, queryItems: query)
    }

    static func todaySummary(userId: String, dateISO: String) -> Endpoint {
        let query = [URLQueryItem(name: "userId", value: userId), URLQueryItem(name: "date", value: dateISO)]
        return Endpoint(path: "api/v1/timings/today", method: .get, queryItems: query)
    }

    static func workPayroll(userId: String, month: Int, year: Int, tenantId: String) -> Endpoint {
        let query = [
            URLQueryItem(name: "userId", value: userId),
            URLQueryItem(name: "month", value: String(month)),
            URLQueryItem(name: "year", value: String(year)),
            URLQueryItem(name: "tenantId", value: tenantId)
        ]
        return Endpoint(path: "api/v1/work/payroll", method: .get, queryItems: query)
    }

    static func quickLinks(userId: String, tenantId: String) -> Endpoint {
        let query = [URLQueryItem(name: "userId", value: userId), URLQueryItem(name: "tenantId", value: tenantId)]
        return Endpoint(path: "api/v1/quick-links", method: .get, queryItems: query)
    }
}
