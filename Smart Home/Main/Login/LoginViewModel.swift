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
//    var loginButtonEnabled: Observable<Bool> {
//        inProgress.asObservable()
//            .map { [weak self] _ in
//                return self?.emailTextFieldViewModel.validate() ?? false
//                    && self?.passwordTextFieldViewModel.validate() ?? false
//            }
//    }
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
                    && password.count > 3
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

/*
 func fetchDevices() {
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
     //self.ref.child("users").child(user.uid).setValue(["username": username])
//        rootRef.ref.child("").child("").setValue(["": ""])
//        dataBase.child("").
     let conditionRef = dataBase.child("users/T3TBRXu8E5ZWw9pmCdWAmQNJQkm2/devices")
//        ref.child("users/7eb5de3b-9075-4fb8-8a04-9339be93c330").getData { (error, snapshot) in
//
//        }
     
         
     conditionRef.observe(.value) { [weak self] snap in
         guard let result = snap.value as? [ResultMap] else { return }
         let devicesResponse = DevicesResponse(result)
//            self?.devices.accept(devicesResponse.devices ?? [])
     }
     
     //            completion(userId)
     //            let object: [String: Any] = ["devices": [nil]]
     //            self.fetchDevices()
     //            self.dataBase.child(userId).setValue(object)
                 
                 // doczytać
     // https://community.appinventor.mit.edu/t/how-do-we-connect-to-firebase-db-using-oauth2-from-app-inventor/13810/13
                 //result?.user.uid
     //            user doesn't exist, do you want to create one?
 }
 */
