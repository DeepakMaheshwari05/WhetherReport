//
//  MockAPIManager.swift
//  WhetherReportTests
//
//  Created by deepakmaheshwari on 22/02/24.
//

import Foundation
@testable import WhetherReport

class MockAPIManager {
    var shouldSucceed: Bool = true
    
    func getWeatherDataFromServer(CompletionBlockWithSuccess completion: @escaping (Result<WeatherData, DataError>) -> Void)  {
        if shouldSucceed {
            guard let data = mockWeatherData() else {
                return completion(.failure(.invalidData))
            }
            
            completion(.success(data))
        } else {
            completion(.failure(.invalidData))
        }
    }

    func getForecastDataFromServer(CompletionBlockWithSuccess completion: @escaping (Result<WeatherDataList, DataError>) -> Void)  {
        if shouldSucceed {
            guard let data = mockWeatherDataList() else {
                return completion(.failure(.invalidData))
            }
            
            completion(.success(data))
        } else {
            completion(.failure(.invalidData))
        }
    }

    func mockWeatherData() -> WeatherData? {
        
        let json =
        """
                    {
                      "coord": {
                        "lon": 77.2167,
                        "lat": 28.6667
                      },
                      "weather": [
                        {
                          "id": 721,
                          "main": "Haze",
                          "description": "haze",
                          "icon": "50n"
                        }
                      ],
                      "base": "stations",
                      "main": {
                        "temp": 292.1,
                        "feels_like": 291.07,
                        "temp_min": 292.1,
                        "temp_max": 292.2,
                        "pressure": 1015,
                        "humidity": 39
                      },
                      "visibility": 3500,
                      "wind": {
                        "speed": 2.57,
                        "deg": 300
                      },
                      "clouds": {
                        "all": 1
                      },
                      "dt": 1708617321,
                      "sys": {
                        "type": 2,
                        "id": 145989,
                        "country": "IN",
                        "sunrise": 1708565055,
                        "sunset": 1708605934
                      },
                      "timezone": 19800,
                      "id": 1273294,
                      "name": "Delhi",
                      "cod": 200
                    }
        """
        
        do {
                
          if  let jsonData = json.data(using: .utf8) {
                let decodedData = try JSONDecoder().decode(WeatherData.self,from: jsonData)
                return decodedData
                }
            } catch {
                print(error)
            }
        return nil
    }
    
    func mockWeatherDataList() -> WeatherDataList? {
        
        let json =
        """
                    {
                      "cod": "200",
                      "message": 0,
                      "cnt": 1,
                      "list": [
                        {
                          "dt": 1708624800,
                          "main": {
                            "temp": 291.46,
                            "feels_like": 290.16,
                            "temp_min": 290.17,
                            "temp_max": 291.46,
                            "pressure": 1015,
                            "sea_level": 1015,
                            "grnd_level": 988,
                            "humidity": 31,
                            "temp_kf": 1.29
                          },
                          "weather": [
                            {
                              "id": 800,
                              "main": "Clear",
                              "description": "clear sky",
                              "icon": "01n"
                            }
                          ],
                          "clouds": {
                            "all": 2
                          },
                          "wind": {
                            "speed": 2.78,
                            "deg": 342,
                            "gust": 6.71
                          },
                          "visibility": 10000,
                          "pop": 0,
                          "sys": {
                            "pod": "n"
                          },
                          "dt_txt": "2024-02-22 18:00:00"
                        }
                      ],
                      "city": {
                        "id": 1273294,
                        "name": "Delhi",
                        "coord": {
                          "lat": 28.6667,
                          "lon": 77.2167
                        },
                        "country": "IN",
                        "population": 10927986,
                        "timezone": 19800,
                        "sunrise": 1708565055,
                        "sunset": 1708605934
                      }
                    }
        """
        
        do {
                
          if  let jsonData = json.data(using: .utf8) {
                let decodedData = try JSONDecoder().decode(WeatherDataList.self,from: jsonData)
                return decodedData
                }
            } catch {
                print(error)
            }
        return nil
    }
}
