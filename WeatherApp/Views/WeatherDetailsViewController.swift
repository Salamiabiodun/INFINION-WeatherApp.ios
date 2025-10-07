import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    
    var viewModel: WeatherDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherLabel.text = viewModel.weatherInfo
    }
}
