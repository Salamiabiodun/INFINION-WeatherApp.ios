import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
}

// MARK: - Weather
struct Weather: Codable {
    let description: String
}
