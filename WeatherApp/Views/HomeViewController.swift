import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    private var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkService = NetworkService()
        let persistenceService = PersistenceService()
        viewModel = HomeViewModel(networkService: networkService, persistenceService: persistenceService)
        
        cityTextField.text = viewModel.favoriteCity
        
        viewModel.weatherInfo = { [weak self] info in
            self?.performSegue(withIdentifier: "showWeatherDetails", sender: info)
        }
        
        viewModel.onError = { [weak self] error in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    @IBAction func getWeatherTapped(_ sender: UIButton) {
        guard let city = cityTextField.text, !city.isEmpty else { return }
        viewModel.fetchWeather(for: city)
    }
    
    @IBAction func saveFavoriteTapped(_ sender: UIButton) {
        guard let city = cityTextField.text, !city.isEmpty else { return }
        viewModel.saveFavoriteCity(city)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeatherDetails",
           let destinationVC = segue.destination as? WeatherDetailsViewController,
           let weatherInfo = sender as? String {
            destinationVC.viewModel = WeatherDetailsViewModel(weatherInfo: weatherInfo)
        }
    }
}
