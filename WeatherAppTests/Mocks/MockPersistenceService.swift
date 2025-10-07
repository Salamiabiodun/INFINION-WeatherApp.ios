import Foundation
@testable import WeatherApp

class MockPersistenceService: PersistenceServiceProtocol {
    
    private var favoriteCity: String?

    func saveFavoriteCity(_ city: String) {
        favoriteCity = city
    }

    func getFavoriteCity() -> String? {
        return favoriteCity
    }
}
