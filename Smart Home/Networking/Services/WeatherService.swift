//
//  WeatherService.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 12/06/2021.
//

import Foundation

class WeatherService: NetworkService {
    func getWeatcher(completion: @escaping (WeatherDTO) -> Void) {
        make(request: WeatherRequest()) { (result: Result<WeatherDTO,Error>) in
            switch result {
            case .success(let model):
                completion(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getLocationData(completion: @escaping (LocationDataDTO) -> Void) {
        make(request: LocationDataRequest()) { (result: Result<LocationDataDTO,Error>) in
            switch result {
            case .success(let model):
                completion(model)
            case .failure(let error):
                print(error)
            }
        }
    }
}

//https://api.tomtom.com/search/2/reverseGeocode/50.01312099059193,19.880571331092085.json?key=ABldGlDAB18quMATY7GDNZfixE8t6nUu
