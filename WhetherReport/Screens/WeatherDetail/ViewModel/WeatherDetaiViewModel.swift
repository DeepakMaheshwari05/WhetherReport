//
//  WeatherDetaiViewModel.swift
//  WhetherReport
//
//  Created by deepakmaheshwari on 20/02/24.
//

import Foundation

class WeatherDetaiViewModel {
    private var weatherDataObj: WeatherData? = nil
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure

    func fetchWeatherData() {
        APIManager().getWeatherDataFromServer { [weak self] (response) in
            guard let self = self else { return }
                switch response {
                case .success(let weatherData):
                        self.weatherDataObj = weatherData
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }

    var cityName: String {
        return weatherDataObj?.name ?? Constant.General.BlankString
    }

    var countryName: String {
        return weatherDataObj?.sys.country ?? Constant.General.BlankString
    }
    
    var temprature: String {
        return "\(weatherDataObj?.main.temp ?? Constant.General.DefaultValue)" + Constant.General.Degree
    }
    
    var minTemprature: String {
        return "\(weatherDataObj?.main.tempMin ?? Constant.General.DefaultValue)" + Constant.General.Degree
    }
    
    var maxTemprature: String {
        return "\(weatherDataObj?.main.tempMax ?? Constant.General.DefaultValue)" + Constant.General.Degree
    }
    
    var humidity: Int {
        return weatherDataObj?.main.humidity ?? Int(Constant.General.DefaultValue)
    }
    
    var weatherIcon: String {
        return weatherDataObj?.weather.first?.icon ?? Constant.General.BlankString
    }
    
    var weatherDescription: String {
        return weatherDataObj?.weather.first?.description.capitalized ?? Constant.General.BlankString
    }
    
    var wind: String {
        return "\(weatherDataObj?.wind.speed.rounded() ?? Constant.General.DefaultValue)" + " m/s"
    }
    
    var date: String {
        return "Today,\(Date().formatted(.dateTime.month().day().hour().minute()))"
    }
}

enum Event {
    case dataLoaded
    case error(Error?)
}
