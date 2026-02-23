import Foundation

// MARK: - Dashboard Root

/// Root DTO representing the entire home dashboard payload returned by the backend.
public struct DashboardHomeDTO: Codable, Equatable, Hashable {
    public let user: DashboardUserDTO
    public let todaySummary: TodaySummaryDTO
    public let workPayroll: WorkPayrollDTO
    public let leaveQuotas: [LeaveQuotaDTO]
    public let wfhQuota: WFHQuotaDTO
    public let quickLinks: [QuickLinkDTO]

    public init(
        user: DashboardUserDTO,
        todaySummary: TodaySummaryDTO,
        workPayroll: WorkPayrollDTO,
        leaveQuotas: [LeaveQuotaDTO],
        wfhQuota: WFHQuotaDTO,
        quickLinks: [QuickLinkDTO]
    ) {
        self.user = user
        self.todaySummary = todaySummary
        self.workPayroll = workPayroll
        self.leaveQuotas = leaveQuotas
        self.wfhQuota = wfhQuota
        self.quickLinks = quickLinks
    }
}

// MARK: - User / Greeting

public struct DashboardUserDTO: Codable, Equatable, Hashable, Identifiable {
    public let id: Int
    public let employeeCode: String
    public let firstName: String
    public let lastName: String
    public let fullName: String
    public let designation: String?
    public let officeLocation: String?
    public let tenantCode: String?
    public let profileImageURL: URL?
    public let timezone: String?

    public init(
        id: Int,
        employeeCode: String,
        firstName: String,
        lastName: String,
        fullName: String,
        designation: String? = nil,
        officeLocation: String? = nil,
        tenantCode: String? = nil,
        profileImageURL: URL? = nil,
        timezone: String? = nil
    ) {
        self.id = id
        self.employeeCode = employeeCode
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.designation = designation
        self.officeLocation = officeLocation
        self.tenantCode = tenantCode
        self.profileImageURL = profileImageURL
        self.timezone = timezone
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case employeeCode
        case firstName
        case lastName
        case fullName
        case designation
        case officeLocation
        case tenantCode
        case profileImageURL = "profileImageUrl"
        case timezone
    }
}

// MARK: - Today's Summary / Timings

public struct TodaySummaryDTO: Codable, Equatable, Hashable {
    public let date: Date
    public let clockedSeconds: Int
    public let breakSeconds: Int
    public let firstInTime: Date?
    public let lastOutTime: Date?

    public init(
        date: Date,
        clockedSeconds: Int,
        breakSeconds: Int,
        firstInTime: Date? = nil,
        lastOutTime: Date? = nil
    ) {
        self.date = date
        self.clockedSeconds = clockedSeconds
        self.breakSeconds = breakSeconds
        self.firstInTime = firstInTime
        self.lastOutTime = lastOutTime
    }

    private enum CodingKeys: String, CodingKey {
        case date = "workingDate"
        case clockedSeconds
        case breakSeconds
        case firstInTime
        case lastOutTime
    }
}

// MARK: - Work & Payroll

public struct WorkPayrollDTO: Codable, Equatable, Hashable {
    public let expectedSeconds: Int
    public let officeSeconds: Int
    public let wfhSeconds: Int
    public let externalReportedSeconds: Int
    public let externalApprovedSeconds: Int
    public let payrollSeconds: Int
    public let utilizationPercentage: Double

    public init(
        expectedSeconds: Int,
        officeSeconds: Int,
        wfhSeconds: Int,
        externalReportedSeconds: Int,
        externalApprovedSeconds: Int,
        payrollSeconds: Int,
        utilizationPercentage: Double
    ) {
        self.expectedSeconds = expectedSeconds
        self.officeSeconds = officeSeconds
        self.wfhSeconds = wfhSeconds
        self.externalReportedSeconds = externalReportedSeconds
        self.externalApprovedSeconds = externalApprovedSeconds
        self.payrollSeconds = payrollSeconds
        self.utilizationPercentage = utilizationPercentage
    }
}

// MARK: - Leave & WFH Quotas

public enum LeaveType: String, Codable {
    case casual
    case sick
    case earned
    case optional
    case wfh
    case unpaid
    case maternity
    case paternity
    case compensatory
    case other
}

public enum QuotaPeriodUnit: String, Codable {
    case yearly
    case quarterly
    case monthly
    case weekly
    case custom
}

public struct LeaveQuotaDTO: Codable, Equatable, Hashable, Identifiable {
    public let id: Int
    public let leaveType: LeaveType
    public let displayName: String
    public let periodUnit: QuotaPeriodUnit
    public let daysEntitled: Double
    public let daysAvailed: Double
    public let daysBalance: Double

    public init(
        id: Int,
        leaveType: LeaveType,
        displayName: String,
        periodUnit: QuotaPeriodUnit,
        daysEntitled: Double,
        daysAvailed: Double,
        daysBalance: Double
    ) {
        self.id = id
        self.leaveType = leaveType
        self.displayName = displayName
        self.periodUnit = periodUnit
        self.daysEntitled = daysEntitled
        self.daysAvailed = daysAvailed
        self.daysBalance = daysBalance
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case leaveType
        case displayName
        case periodUnit
        case daysEntitled
        case daysAvailed
        case daysBalance
    }
}

public struct WFHQuotaDTO: Codable, Equatable, Hashable {
    public let periodUnit: QuotaPeriodUnit
    public let daysEntitled: Double
    public let daysAvailed: Double
    public let daysBalance: Double

    public init(
        periodUnit: QuotaPeriodUnit,
        daysEntitled: Double,
        daysAvailed: Double,
        daysBalance: Double
    ) {
        self.periodUnit = periodUnit
        self.daysEntitled = daysEntitled
        self.daysAvailed = daysAvailed
        self.daysBalance = daysBalance
    }
}

// MARK: - Quick Links

public struct QuickLinkDTO: Codable, Equatable, Hashable, Identifiable {
    public let id: String
    public let title: String
    public let iconSystemName: String
    public let targetURL: URL
    public let isExternal: Bool
    public let sortOrder: Int?

    public init(
        id: String,
        title: String,
        iconSystemName: String,
        targetURL: URL,
        isExternal: Bool,
        sortOrder: Int? = nil
    ) {
        self.id = id
        self.title = title
        self.iconSystemName = iconSystemName
        self.targetURL = targetURL
        self.isExternal = isExternal
        self.sortOrder = sortOrder
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case iconSystemName
        case targetURL = "targetUrl"
        case isExternal
        case sortOrder
    }
}
