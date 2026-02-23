// filepath: Networking/Endpoint.swift
import Foundation

public enum HTTPMethod: String {
    case get = "GET", post = "POST", put = "PUT", delete = "DELETE"
}

public struct Endpoint {
    public var path: String
    public var method: HTTPMethod
    public var queryItems: [URLQueryItem]
    public var headers: [String: String]

    public init(path: String, method: HTTPMethod = .get, queryItems: [URLQueryItem] = [], headers: [String: String] = [:]) {
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
    }
}
