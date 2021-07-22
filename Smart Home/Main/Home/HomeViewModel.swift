//
//  HomeViewModel.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 11/03/2021.
//

import Foundation
import Firebase
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
    
    init(service: WeatherService) {
        self.service = service
    }
    
    func fetchDevices() {
        //self.ref.child("users").child(user.uid).setValue(["username": username])
//        rootRef.ref.child("").child("").setValue(["": ""])
        let conditionRef = dataBase.child(Constants.rootRefChild)
        conditionRef.observe(.value) { [weak self] snap in
            guard let result = snap.value as? [ResultMap] else { return }
            let devicesResponse = DevicesResponse(result)
            self?.devices.accept(devicesResponse.devices ?? [])
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
