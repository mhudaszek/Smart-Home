//
//  WeatherService.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 18/04/2021.
//

import Foundation

struct Coord: Codable {
    let lon: Int
    let lat: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
    let gust: Double?
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

struct WeatherObject: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

class RequestService {


}

class WeatherService {
    class func currentWeather() {
        let headers = [
            "x-rapidapi-key": "4e887b1126mshfe2f46f008495e6p10f2a3jsnd976c6daf278",
            "x-rapidapi-host": "community-open-weather-map.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://community-open-weather-map.p.rapidapi.com/weather?q=Poland%2Cpl&lat=0&lon=0&id=2172797&lang=null&units=%22metric%22%20or%20%22imperial%22&mode=xml%2C%20html")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let decoder = JSONDecoder()
        let task = session.dataTask(with: request as URLRequest) { (data, res, error) in

            DispatchQueue.main.async {

                if let data = data {

                    guard let httpResponse = res as? HTTPURLResponse else {
                        //                        completion(nil, DarkSkyError.requestFailed)
                        return
                    }

                    // Check if request is successful
                    if httpResponse.statusCode == 200 {
                        do {
                            // decode to type Weather, from data (JSON)
                            let weather = try decoder.decode(WeatherObject.self, from: data)
                             print(weather)
                        } catch let error {
                            print(error)
                            //                            completion(nil, error)
                            //                        }
                        }

                    } else if let error = error {
                        //                    completion(nil, error)
                    }
                }

            }
            // Resume the task

            //        let session = URLSession.shared
            //        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            //
            //            if error != nil {
            //                print(error!)
            //                return
            //            }
            //            do {
            //                let parseJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            //                print(parseJSON)
            //            } catch let error as NSError {
            //                print("Failed to load: \(error.localizedDescription)")
            //            }
            //        }
            //        task.resume()

        }
        task.resume()
    }
}
