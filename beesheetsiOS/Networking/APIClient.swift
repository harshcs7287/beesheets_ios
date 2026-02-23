// filepath: Networking/APIClient.swift
import Foundation

public enum APIError: Error {
    case invalidURL
    case network(underlying: Error)
    case serverError(statusCode: Int, data: Data?)
    case decoding(underlying: Error)
}

public final class APIClient {
    private let baseURL: URL
    private let authTokenProvider: (() -> String?)?
    private let session: URLSession

    public init(baseURL: URL, authTokenProvider: (() -> String?)? = nil, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.authTokenProvider = authTokenProvider
        self.session = session
    }

    public func request<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T {
        // Build URL
        guard var components = URLComponents(url: baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }

        if !endpoint.queryItems.isEmpty {
            components.queryItems = endpoint.queryItems
        }

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        if let token = authTokenProvider?() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        do {
            let (data, response) = try await session.data(for: request)

            if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
                throw APIError.serverError(statusCode: http.statusCode, data: data)
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601

            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw APIError.decoding(underlying: error)
            }
        } catch let err as APIError {
            throw err
        } catch {
            throw APIError.network(underlying: error)
        }
    }
}
