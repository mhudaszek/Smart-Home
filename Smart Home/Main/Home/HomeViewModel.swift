//
//  HomeViewModel.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 11/03/2021.
//

import Foundation
import Firebase
import FirebaseAuth
import RxCocoa
import RxSwift

final class HomeViewModel {
    private enum Constants {
        static let rootRefChild: String = "devices"
    }
    private let service: WeatherService
    private let dataBase = Database.database().reference()
    let devices = BehaviorRelay<[Device]>(value: [])
    private var disposeBag = DisposeBag()
    
    private var ref: DatabaseReference
    
    init(service: WeatherService) {
        self.service = service
        self.ref = Database.database().reference()
    }
    
    func fetchDevices() {
        ref.child("users/7eb5de3b-9075-4fb8-8a04-9339be93c330").observe(.value) { [weak self] result in
            let devicesResponse = DevicesResponse(result.value)
            self?.devices.accept(devicesResponse.devices)
        }
    }
    
    func fetchCurrentWeather(completion: @escaping (WeatherModel) -> Void) {
        fetchLocationData()
        service.getWeatcher { [weak self] weatherDTO in
            self?.service.getLocationData { locationDataDTO in
                let model = WeatherModel(weatherDTO: weatherDTO, locationDataDTO: locationDataDTO)
                completion(model)
            }
            
        }
    }
    
    func fetchLocationData() {
        service.getLocationData { locationData in
            print(locationData)
        }
    }
}
