import XCTest
@testable import WeatherApp

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockNetworkService: MockNetworkService!
    var mockPersistenceService: MockPersistenceService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        mockPersistenceService = MockPersistenceService()
        viewModel = HomeViewModel(networkService: mockNetworkService, persistenceService: mockPersistenceService)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        mockPersistenceService = nil
        super.tearDown()
    }

    func testFetchWeather_Success() {
        // Given
        let weatherResponse = WeatherResponse(weather: [Weather(description: "clear sky")], main: Main(temp: 25.0))
        mockNetworkService.fetchWeatherResult = .success(weatherResponse)
        
        let expectation = self.expectation(description: "Weather info closure should be called")
        
        // When
        viewModel.weatherInfo = { info in
            XCTAssertEqual(info, "Temperature: 25.0°C, Description: clear sky")
            expectation.fulfill()
        }
        viewModel.fetchWeather(for: "London")
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchWeather_Failure() {
        // Given
        mockNetworkService.fetchWeatherResult = .failure(.noData)
        
        let expectation = self.expectation(description: "Error closure should be called")
        
        // When
        viewModel.onError = { error in
            XCTAssertEqual(error, "The operation couldn’t be completed. (WeatherApp.NetworkError error 1.)")
            expectation.fulfill()
        }
        viewModel.fetchWeather(for: "London")
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSaveFavoriteCity() {
        // When
        viewModel.saveFavoriteCity("Paris")
        
        // Then
        XCTAssertEqual(mockPersistenceService.getFavoriteCity(), "Paris")
    }
    
    func testGetFavoriteCity() {
        // Given
        mockPersistenceService.saveFavoriteCity("Tokyo")
        
        // When
        let favoriteCity = viewModel.favoriteCity
        
        // Then
        XCTAssertEqual(favoriteCity, "Tokyo")
    }
}
