// filepath: Utilities/EnvironmentConfig.swift
import Foundation

enum EnvironmentConfig {
    /// Base URL used by `APIClient`. Replace with a real backend URL in production.
    static let apiBaseURL = URL(string: "http://localhost:8080/")!
}
