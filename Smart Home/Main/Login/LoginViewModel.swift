//
//  LoginViewModel.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 15/06/2021.
//

import Foundation
import Firebase
import FirebaseAuth
import RxSwift
import RxCocoa

class LoginViewModel {
    private let dataBase = Database.database().reference()

    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let inProgress = BehaviorRelay<Bool>(value: false)

    let loginSucceeded = PublishSubject<String>()
    let emailTextFieldViewModel = FormTextFieldViewModel(image: #imageLiteral(resourceName: "user_login_icon"),
                                                         placeholderText: "Login")
    let passwordTextFieldViewModel = FormTextFieldViewModel(image: #imageLiteral(resourceName: "password_Icon"),
                                                            placeholderText: "Password",
                                                            isSecureTextEntry: true)
    
    var loginButtonEnabled: Observable<Bool> {
        Observable.combineLatest(email.asObservable(), password.asObservable(), inProgress.asObservable())
            .map { email, password, inProgress in
                email.isValidEmail
                    && !password.isEmpty
                    && password.count >= 6
                    && !inProgress
            }
    }
 
    private var disposeBag = DisposeBag()
    
    init() {
        setupRx()
    }
    
    private func setupRx() {
        emailTextFieldViewModel.text
            .bind(to: email)
            .disposed(by: disposeBag)

        passwordTextFieldViewModel.text
            .bind(to: password)
            .disposed(by: disposeBag)
    }

    func login(completion: @escaping () -> Void) {
        inProgress.accept(true)
        Auth.auth().signIn(withEmail: email.value, password: password.value) { [weak self] result, error in
            if error != nil {
                self?.inProgress.accept(false)
                completion()
                return
            }
            self?.inProgress.accept(false)
            self?.loginSucceeded.onNext(result?.user.uid ?? "")
        }
    }

    func createNewUser(completion: @escaping (Error?) -> Void) {
        inProgress.accept(true)
        Auth.auth().createUser(withEmail: email.value, password: password.value) { [weak self] result, error in
            if error != nil {
                self?.inProgress.accept(false)
                completion(error)
                return
            }
            self?.inProgress.accept(false)
            self?.loginSucceeded.onNext(result?.user.uid ?? "")
        }
    }

    func createNewAccountAlertConfig(action: @escaping AlertAction) -> AlertConfig {
        let yesAction = UIAlertAction(title: "Yes",
                                         style: .destructive,
                                         handler: action)
        let noAction = UIAlertAction(title: "No",
                                        style: .default,
                                        handler: nil)
        return AlertConfig(title: "Account does not exist. Do you want to create one",
                                      message: "",
                                      okAction: yesAction,
                                      cancelAction: noAction)
    }
}
