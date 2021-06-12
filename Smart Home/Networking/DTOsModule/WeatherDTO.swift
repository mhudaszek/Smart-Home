//
//  WeatherDTO.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 12/06/2021.
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

struct WeatherDTO: Codable {
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

struct WeatherModel {
    let cityName: String
    let weatherIconUrl: String
    let weatherDescription: String
    let pressure: String
    let temperature: String
    
    init(weatherDTO: WeatherDTO, locationDataDTO: LocationDataDTO) {
        self.cityName = locationDataDTO.addresses.first?.address.localName ?? ""
        self.weatherIconUrl = "https://openweathermap.org/img/wn/\(weatherDTO.weather.first?.icon ?? "")@2x.png"
        self.weatherDescription = weatherDTO.weather.first?.description ?? ""
        self.pressure = String(weatherDTO.main.pressure) + " hPa"
        self.temperature = String(Int(weatherDTO.main.temp_max)) + " °C"
    }
}
