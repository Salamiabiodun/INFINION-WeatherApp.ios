import Foundation
@testable import WeatherApp

class MockNetworkService: NetworkServiceProtocol {
    
    var fetchWeatherResult: Result<WeatherResponse, NetworkError>?

    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        if let result = fetchWeatherResult {
            completion(result)
        }
    }
}
