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
    let validators: [Validator]

    var error: Observable<String?> {
        return errorSubject.asObservable()
    }

    private let errorSubject = BehaviorSubject<String?>(value: nil)

    init(validators: [Validator] = [], image: UIImage, placeholderText: String) {
        self.image = image
        self.placeholderText = placeholderText
        self.validators = validators
    }

    func validate() -> Bool {
        dismissError()
        for validator in validators {
            if let errorMessage = validator.validate(text: text.value) {
               errorSubject.onNext(errorMessage)
                return false
            }
        }
        return true
    }

    func dismissError() {
        errorSubject.onNext(nil)
    }

}

// przenieść
typealias ValidationError = String?

protocol Validator {

    func validate(text: String) -> ValidationError

}
