//
//  WeatherForcastViewModel.swift
//  WhetherReport
//
//  Created by deepakmaheshwari on 22/02/24.
//

import Foundation

class WeatherForcastViewModel {
    
    var weatherForecastDataObj: [WeatherForecastData]  = []
    
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure

    func fetchWeatherData() {
        APIManager().getForecastDataFromServer { [weak self] (response) in
            guard let self = self else { return }
                switch response {
                case .success(let weatherDataListObj):
                    self.refactorForecastData(weatherDataList: weatherDataListObj)
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }

    func refactorForecastData(weatherDataList: WeatherDataList) {
        var date = Date()
        weatherDataList.list.forEach { list in
            let tempDate = list.dt.dateFromTimeinterval()
            if date.compare(secondDate: tempDate) == .earlier {
                date = tempDate
                weatherForecastDataObj.append(WeatherForecastData(dateText: tempDate.getDayName() + "," + tempDate.getStringDate() , weatherDescription: list.weather.first?.description ?? Constant.General.BlankString, temp: "\(list.main.temp)"))
            }
        }
    }
}
