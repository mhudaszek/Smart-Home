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
    private let userId: String
    private let service: WeatherService
    private let dataBase = Database.database().reference()
    var weatherModel: WeatherModel?

    let devices = BehaviorRelay<[Device]>(value: [])
    let inProgress = BehaviorRelay<Bool>(value: true)
    private var disposeBag = DisposeBag()
    
    private var database: DatabaseReference
    private let group = DispatchGroup()

    init(service: WeatherService, userId: String) {
        self.service = service
        self.userId = userId
        self.database = Database.database().reference()
    }
    
    func fetch() {
        inProgress.accept(true)
        fetchCurrentWeather()
        fetchDevices()
        group.notify(queue: .main) { [weak self] in
            self?.inProgress.accept(false)
        }
    }
    
    func fetchDevices() {
        group.enter()
        database.child("users/\(userId)").observe(.value) { [weak self] result in
            let devicesResponse = DevicesResponse(result.value)
            self?.devices.accept(devicesResponse.devices)
            self?.group.leave()
        }
    }

    func fetchCurrentWeather() {
        group.enter()
        service.getWeatcher { [weak self] weatherDTO in
            self?.service.getLocationData { [weak self] locationDataDTO in
                self?.weatherModel = WeatherModel(weatherDTO: weatherDTO,
                                         locationDataDTO: locationDataDTO)
                self?.group.leave()
            }
        }
    }
}
