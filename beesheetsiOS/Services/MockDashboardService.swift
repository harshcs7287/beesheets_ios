import Foundation

public struct MockDashboardService: DashboardServiceProtocol {
    let delay: TimeInterval
    let decoder: JSONDecoder

    public init(delay: TimeInterval = 0.3, decoder: JSONDecoder? = nil) {
        self.delay = delay
        if let decoder = decoder {
            self.decoder = decoder
        } else {
            let d = JSONDecoder()
            d.keyDecodingStrategy = .convertFromSnakeCase
            d.dateDecodingStrategy = .iso8601
            self.decoder = d
        }
    }
    
    public func fetchDashboardHome() async throws -> DashboardHomeDTO {
        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))

        let data: Data
        do {
            data = try loadMockJSON()
        } catch {
            throw DashboardServiceError.failedToLoadMockData
        }

        do {
            let dto = try decoder.decode(DashboardHomeDTO.self, from: data)
            return dto
        } catch {
            throw DashboardServiceError.decodingFailed(underlying: error)
        }
    }


    private func loadMockJSON() throws -> Data {
           let resourceName = "dashboard_home_mock"
           let filename = "\(resourceName).json"

           if let url = Bundle.main.url(forResource: resourceName, withExtension: "json") {
               if let data = try? Data(contentsOf: url) { return data }
           }
           let possibleSubdirs: [String?] = ["MockData", "Resources/MockData", "Resources", nil]
           for subdir in possibleSubdirs {
               if let url = Bundle.main.url(forResource: resourceName, withExtension: "json", subdirectory: subdir) {
                   if let data = try? Data(contentsOf: url) { return data }
               }
           }
           if let urls = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: nil) {
               if let match = urls.first(where: { $0.lastPathComponent == filename || $0.path.contains("/MockData/") }) {
                   if let data = try? Data(contentsOf: match) { return data }
               }
           }
           throw DashboardServiceError.failedToLoadMockData
       }
}
