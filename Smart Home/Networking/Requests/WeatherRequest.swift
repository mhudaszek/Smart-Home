//
//  WeatherRequest.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 12/06/2021.
//

import Foundation

struct WeatherRequest: NetworkRequest {
    var path: String {
        let lat = LocationService.shared.currentLocation?.coordinate.latitude ?? 0
        let lon = LocationService.shared.currentLocation?.coordinate.longitude ?? 0
        return "https://community-open-weather-map.p.rapidapi.com/weather?q=Poland%2Cpl&lat=\(lat)&lon=\(lon)&id=2172797&lang=null&units=metric&mode=xml%2C%20html"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return [
            "x-rapidapi-key": "4e887b1126mshfe2f46f008495e6p10f2a3jsnd976c6daf278",
            "x-rapidapi-host": "community-open-weather-map.p.rapidapi.com"
        ]
    }
}

struct LocationDataRequest: NetworkRequest {
    var path: String {
        let lat = LocationService.shared.currentLocation?.coordinate.latitude ?? 0
        let lon = LocationService.shared.currentLocation?.coordinate.longitude ?? 0
        return "https://api.tomtom.com/search/2/reverseGeocode/\(lat),\(lon).json?key=ABldGlDAB18quMATY7GDNZfixE8t6nUu"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return nil
//        return [
//            "x-rapidapi-key": "4e887b1126mshfe2f46f008495e6p10f2a3jsnd976c6daf278",
//            "x-rapidapi-host": "community-open-weather-map.p.rapidapi.com"
//        ]
    }
}

