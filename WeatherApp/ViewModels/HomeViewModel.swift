import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    
    private let networkService: NetworkServiceProtocol
    private let persistenceService: PersistenceServiceProtocol
    
    var weatherInfo: ((String) -> Void)?
    var onError: ((String) -> Void)?
    
    var favoriteCity: String? {
        return persistenceService.getFavoriteCity()
    }
    
    // MARK: - Initialization
    
    init(networkService: NetworkServiceProtocol, persistenceService: PersistenceServiceProtocol) {
        self.networkService = networkService
        self.persistenceService = persistenceService
    }
    
    // MARK: - Public Methods
    
    func fetchWeather(for city: String) {
        networkService.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let weatherDescription = response.weather.first?.description ?? "No description"
                    let temperature = response.main.temp
                    self?.weatherInfo?("Temperature: \(temperature)°C, Description: \(weatherDescription)")
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func saveFavoriteCity(_ city: String) {
        persistenceService.saveFavoriteCity(city)
    }
}
