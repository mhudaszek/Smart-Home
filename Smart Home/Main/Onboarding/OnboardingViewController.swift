//
//  OnboardingViewController.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 02/03/2021.
//

import UIKit
import Firebase

class OnboardingViewController: ViewController {
    private let onboardingView = OnboardingView()
    weak var coordinator: AppCoordinator?

    let rootRef = Database.database().reference()

    override func loadView() {
        view = onboardingView
    }

    override func setup() {
        super.setup()
        startAnimating()

        let conditionRef = rootRef.child("devices")
        conditionRef.observe(.value) { snap in
            guard let result = snap.value as? [ResultMap] else { return }
            let devicesResponse = DevicesResponse(result)
        }
    }
}

private extension OnboardingViewController {
    func startAnimating() {
        if !onboardingView.animationView.isAnimationPlaying {
            onboardingView.animationView.loopMode = .playOnce
            onboardingView.animationView.play { [weak self] _ in
                self?.coordinator?.coordinateToTabBar()
            }
        }
    }
}

public typealias ResultMap = [String: Any?]

struct Device {
    let id: Int?
    let title: String?

    init(_ resultMap: ResultMap) {
        self.id = resultMap["id"] as? Int
        self.title = resultMap["title"] as? String
    }
}

struct DevicesResponse {
    var devices: [Device]?

    init(_ resultMap: [ResultMap]) {
        self.devices = resultMap.map { Device($0) }
    }
}
