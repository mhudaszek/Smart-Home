//
//  FormTextFieldViewModel.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 14/06/2021.
//

import Foundation
import RxSwift
import RxCocoa

class FormTextFieldViewModel {
    let image: UIImage
    let placeholderText: String
    let text = BehaviorRelay<String>(value: "")
    let isSecureTextEntry: Bool
//    let validators: [Validator]

    var error: Observable<String?> {
        return errorSubject.asObservable()
    }

    private let errorSubject = BehaviorSubject<String?>(value: nil)
//validators: [Validator] = [], 
    init(image: UIImage, placeholderText: String, isSecureTextEntry: Bool = false) {
        self.image = image
        self.placeholderText = placeholderText
        self.isSecureTextEntry = isSecureTextEntry
//        self.validators = validators
    }

//    func validate() -> Bool {
//        dismissError()
//        for validator in validators {
//            if let errorMessage = validator.validate(text: text.value) {
//               errorSubject.onNext(errorMessage)
//                return false
//            }
//        }
//        return true
//    }

    func dismissError() {
        errorSubject.onNext(nil)
    }

}

// przenieść
//typealias ValidationError = String?
//
//protocol Validator {
//
//    func validate(text: String) -> ValidationError
//
//}
