//
//  WhetherReportTests.swift
//  WhetherReportTests
//
//  Created by deepakmaheshwari on 20/02/24.
//

import XCTest
@testable import WhetherReport

final class WhetherReportTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testWeatherURL() {
        let requstUrl = Constant.API.baseURL + Constant.API.weather + Constant.API.cityId + Constant.API.apiId + Constant.API.temprature

        XCTAssertEqual(requstUrl,"https://api.openweathermap.org/data/2.5/weather?q=Delhi,IN&APPID=08ae148abca5b3cccb71e74b1c5d8b2e&units=metric")

    }
    
    func testWeatherDataSuccess() {
        let mockService = MockAPIManager()
        mockService.getWeatherDataFromServer { (response) in
                switch response {
                case .success(let weatherData):
                    XCTAssertEqual(weatherData.dt, 1708617321)
                    XCTAssertEqual(weatherData.main.pressure, 1015)
                    XCTAssertEqual(weatherData.main.humidity, 39)
                    XCTAssertEqual(weatherData.wind.speed, 2.57)
                    XCTAssertEqual(weatherData.main.temp, 292.1)
                case .failure(_):
                    XCTFail("Should not fail")
                }
            }
        }

        func testWeatherDataFailure() {
            let mockService = MockAPIManager()
            mockService.shouldSucceed = false

            mockService.getWeatherDataFromServer { result in
                switch result {
                case .success:
                    XCTFail("Should fail")
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (WhetherReport.DataError error 4.)")
                }
            }
        }
    
    func testForecastDataSuccess() {
        let mockService = MockAPIManager()
        mockService.getForecastDataFromServer { (response) in
                switch response {
                case .success(let weatherData):
                    XCTAssertEqual(weatherData.cnt, 1)
                    XCTAssertEqual(weatherData.list.first?.dt, 1708624800)
                    XCTAssertEqual(weatherData.city.sunrise, 1708565055)
                case .failure(_):
                    XCTFail("Should not fail")
                }
            }
        }

        func testForecastDataFailure() {
            let mockService = MockAPIManager()
            mockService.shouldSucceed = false

            mockService.getForecastDataFromServer { result in
                switch result {
                case .success:
                    XCTFail("Should fail")
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (WhetherReport.DataError error 4.)")
                }
            }
        }

    
}
