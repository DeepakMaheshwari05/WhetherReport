//
//  APIManager.swift
//  WhetherReport
//
//  Created by deepakmaheshwari on 20/02/24.
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case decoding(Error?)
}

class APIManager {

    func getWeatherDataFromServer(CompletionBlockWithSuccess completion: @escaping (Result<WeatherData, DataError>) -> Void)  {
        let urlString = Constant.API.baseURL + Constant.API.weather + Constant.API.cityId + Constant.API.apiId + Constant.API.temprature
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        requestDataAPI(url: url, modelType: WeatherData.self, completion: completion)
    }

    
    func getForecastDataFromServer(CompletionBlockWithSuccess completion: @escaping (Result<WeatherDataList, DataError>) -> Void)  {
        let urlString = Constant.API.baseURL + Constant.API.forecast + Constant.API.cityId + Constant.API.apiId + Constant.API.temprature
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        requestDataAPI(url: url, modelType: WeatherDataList.self, completion: completion)
    }

   private func requestDataAPI<T: Codable>(
        url: URL, modelType: T.Type,
        completion: @escaping (Result<T, DataError>) -> Void
    ) {
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        request.httpMethod = Constant.API.method
        request.allHTTPHeaderFields = Constant.API.headers

        let _ = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            do {
                guard let weatherData = try? JSONDecoder().decode(modelType.self, from: data) else {
                   return completion(.failure(.invalidData))
                }
                completion(.success(weatherData))
            }
        }.resume()
    }

}
