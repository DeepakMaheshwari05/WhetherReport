//
//  WeatherDetailVC.swift
//  WhetherReport
//
//  Created by deepakmaheshwari on 20/02/24.
//

import UIKit

class WeatherDetailVC: UIViewController {

    //MARK: - Properties
    private var weatherDetaiVMObj = WeatherDetaiViewModel()
    let loader = UIAlertController(title: nil, message: Constant.Alert.PleaseWait, preferredStyle: .alert)

    //MARK: - IBOutlet

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var imgWeatherIcon: UIImageView!
    @IBOutlet weak var lblMin: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWaetherCond: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var lblWind: UILabel!
        
    
     //MARK: - UIView methods
    override func viewDidLoad() {
        super.viewDidLoad()
        imgWeatherIcon.roundCorner()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configuration()
    }
        
    @IBAction func goToWeeklyForcast(_ sender: UIButton) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "WeatherForecastVC") as! WeatherForecastVC
            ivc.modalTransitionStyle = .flipHorizontal
            present(ivc, animated: true, completion: nil)
    }
}

extension WeatherDetailVC {
    // MARK: - SetUp Methods
    func configuration() {
        loader.setLoader()
        initViewModel()
        observeEvent()
    }

    func setUpView()  {
        lblCityName.text = weatherDetaiVMObj.cityName + "," + weatherDetaiVMObj.countryName
        imgWeatherIcon.image = UIImage(named: weatherDetaiVMObj.weatherIcon)
        lblDate.text = weatherDetaiVMObj.date
        lblWaetherCond.text = weatherDetaiVMObj.weatherDescription
        lblWind.text = weatherDetaiVMObj.wind
        lblTemp.text = weatherDetaiVMObj.temprature
        lblMin.text = weatherDetaiVMObj.minTemprature
        lblMax.text = weatherDetaiVMObj.maxTemprature
        lblHumidity.text = "\(weatherDetaiVMObj.humidity)"
    }

    func initViewModel() {
        // Fetching
        weatherDetaiVMObj.fetchWeatherData()
    }

    // Data binding event
    func observeEvent() {
        present(loader, animated: true)

        weatherDetaiVMObj.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.setUpView()
                    self.loader.dismiss(animated: true, completion: nil)
                }
                
            case .error(_):
                self.loader.dismiss(animated: true, completion: nil)
                // Showing alert in case of error
                let alert = UIAlertController(title: Constant.Alert.Title, message: Constant.Alert.Message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: Constant.Alert.Button, style: UIAlertAction.Style.default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}
