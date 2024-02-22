//
//  WeatherForecastVC.swift
//  WhetherReport
//
//  Created by deepakmaheshwari on 21/02/24.
//

import UIKit

class WeatherForecastVC: UIViewController {
    
    //MARK: - Properties
    private var weatherForecastVMObj = WeatherForcastViewModel()
    let loader = UIAlertController(title: nil, message: Constant.Alert.PleaseWait, preferredStyle: .alert)

    //MARK: - IBOutlet
    @IBOutlet weak var lblDay1: UILabel!
    @IBOutlet weak var lblDay2: UILabel!
    @IBOutlet weak var lblDay3: UILabel!
    @IBOutlet weak var lblDay5: UILabel!
    @IBOutlet weak var lblDay4: UILabel!
    @IBOutlet weak var lblDay1Temp: UILabel!
    @IBOutlet weak var lblDay2Temp: UILabel!
    @IBOutlet weak var lblDay3Temp: UILabel!
    @IBOutlet weak var lblDay4Temp: UILabel!
    @IBOutlet weak var lblDay5Temp: UILabel!
    @IBOutlet weak var lblDay1Weather: UILabel!
    @IBOutlet weak var lblDay2Weather: UILabel!
    @IBOutlet weak var lblDay3Weather: UILabel!
    @IBOutlet weak var lblDay4Weather: UILabel!
    @IBOutlet weak var lblDay5Weather: UILabel!

    var ibOutletsArrayOne: [UILabel] = []
    var ibOutletsArrayTwo: [UILabel] = []
    var ibOutletsArrayThree: [UILabel] = []

    //MARK: - UIView methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ibOutletsArrayOne = [lblDay1, lblDay2, lblDay3, lblDay4, lblDay5]
        ibOutletsArrayTwo = [lblDay1Temp, lblDay2Temp, lblDay3Temp, lblDay4Temp, lblDay5Temp]
        ibOutletsArrayThree = [lblDay1Weather, lblDay2Weather, lblDay3Weather, lblDay4Weather, lblDay5Weather]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configuration()
    }

    //MARK: - IBAction Methods
    @IBAction func closeView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension WeatherForecastVC {
    
    // MARK: - SetUp Methods
    func configuration() {
        loader.setLoader()
        initViewModel()
        observeEvent()
    }

    func initViewModel() {
        // Fetching
        weatherForecastVMObj.fetchWeatherData()
    }

    // Data binding event
    func observeEvent() {
        present(loader, animated: true)
        weatherForecastVMObj.eventHandler = { [weak self] event in
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
    
    func setUpView()  {
        var iter1 = ibOutletsArrayOne.makeIterator()
        var iter2 = ibOutletsArrayTwo.makeIterator()
        var iter3 = ibOutletsArrayThree.makeIterator()
        var iter4 = weatherForecastVMObj.weatherForecastDataObj.makeIterator()
        while let dateLbl = iter1.next(), let tempLbl = iter2.next(), let descLbl = iter3.next(), let forecast = iter4.next() {
            dateLbl.text = forecast.dateText
            tempLbl.text = forecast.temp + Constant.General.Degree
            descLbl.text = "Weather: " + forecast.weatherDescription.capitalized
        }
    }

}
