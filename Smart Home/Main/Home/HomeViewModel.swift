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
    private let rootRef = Database.database().reference()

    let devices = BehaviorRelay<[Device]>(value: [])
    private var disposeBag = DisposeBag()

    func fetchDevices() {
        let conditionRef = rootRef.child(Constants.rootRefChild)
        conditionRef.observe(.value) { [weak self] snap in
            guard let result = snap.value as? [ResultMap] else { return }
            let devicesResponse = DevicesResponse(result)
            self?.devices.accept(devicesResponse.devices ?? [])
        }
    }
}
