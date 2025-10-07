import Foundation

protocol PersistenceServiceProtocol {
    func saveFavoriteCity(_ city: String)
    func getFavoriteCity() -> String?
}

class PersistenceService: PersistenceServiceProtocol {
    private let favoriteCityKey = "favoriteCity"

    func saveFavoriteCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: favoriteCityKey)
    }

    func getFavoriteCity() -> String? {
        return UserDefaults.standard.string(forKey: favoriteCityKey)
    }
}
