import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

protocol NetworkServiceProtocol {
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    private let apiKey = "06aeb22d07b6782c2a554a808ca2e0e6" // Replace with your actual OpenWeather API key
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"

    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)?q=\(city)&appid=\(apiKey)&units=metric") else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }

            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
