//
//  Constant.swift
//  WhetherReport
//
//  Created by deepakmaheshwari on 20/02/24.
//

import Foundation

enum Constant {
    enum API {
        static let apiId = "&APPID=08ae148abca5b3cccb71e74b1c5d8b2e"
        static let cityId = "?q=Delhi,IN"
        static let weather = "weather"
        static let forecast = "forecast"
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
        static let method = "GET"
        static let temprature = "&units=metric"
        static let headers = ["Content-Type": "application/json"]
    }
    
    enum Alert {
        static let Title = "API Failed"
        static let Message = "There was an error while fetching data from the server. Please try again later."
        static let Button = "Ok"
        static let PleaseWait = "Please wait..."

    }
    
    enum General {
        static let BlankString = ""
        static let DefaultValue = 0.0
        static let Degree = "°C"
    }
}
