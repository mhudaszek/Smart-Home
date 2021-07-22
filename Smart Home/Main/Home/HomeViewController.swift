//
//  HomeViewController.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 03/03/2021.
//

import UIKit
import RxCocoa
import RxSwift

//wywalić
import Firebase
import FirebaseAuth

class HomeViewController: ViewController {
    private let weatherView: WeatherView
    private let underlineSwitchView: UnderlineSwitchView
    private var collectionView = CollectionView().configure {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20

        $0.collectionViewLayout = layout
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    var formTextField = FormTextField()

    private let viewModel: HomeViewModel
    private var disposeBag = DisposeBag()

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.weatherView = WeatherView()
        let underlineSwitchViewModel = UnderlineSwitchViewModel()
        self.underlineSwitchView = UnderlineSwitchView(viewModel: underlineSwitchViewModel)
        super.init()
    }

    override func setup() {
        super.setup()
        title = "Home"
        view.backgroundColor = .white
        addSubviews()
        setupLayout()
        setupNavigationBar()
        setupCollectionView()
        viewModel.fetchDevices()
        viewModel.fetchCurrentWeather { [weak self] model in
            DispatchQueue.main.async {
                self?.weatherView.setupView(with: model)
            }
        }
        setupRx()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//            self.createUser()
        }
        let emailFieldViewModel = FormTextFieldViewModel(validators: [ValuePresenceValidator(fieldName: "e-mail address"), MailValidator()],
                                                              image: #imageLiteral(resourceName: "bulbIconOn"),
                                                              placeholderText: "Email")
        formTextField.bind(viewModel: emailFieldViewModel)
    }
    
    func createUser() {
        
        
//        Auth.auth().signIn(withEmail: "nowyTestowy@o2.pl", password: "qwedsdfs") { result, error in
//            if error != nil {
//                print("error")
//            }
//            print(result)
//        }
    }
}

private extension HomeViewController {
    func addSubviews() {
        view.addSubview(weatherView)
        view.addSubview(collectionView)
        view.addSubview(underlineSwitchView)
        
        view.addSubview(formTextField)
//        view.activateConstraints(with: collectionView, left: 20, right: 20)
    }

    func setupLayout() {
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        underlineSwitchView.translatesAutoresizingMaskIntoConstraints = false
        formTextField.translatesAutoresizingMaskIntoConstraints = false
        formTextField.backgroundColor = .yellow
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            underlineSwitchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            underlineSwitchView.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 20),
            underlineSwitchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            underlineSwitchView.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            underlineSwitchView.heightAnchor.constraint(equalToConstant: 50),

            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            formTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            formTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            formTextField.heightAnchor.constraint(equalToConstant: 50)
//            formTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DeviceCell.self)
    }

    func setupRx() {
        viewModel.devices
            .subscribe { [weak self] _ in self?.collectionView.reloadData()}
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.devices.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(DeviceCell.self, at: indexPath)

        let deviceCellViewModel = DeviceCellViewModel(device: viewModel.devices.value[indexPath.row])
        cell.setup(with: deviceCellViewModel)

//        cell.showDetailsDidTapped = { [weak self] in
//            self?.coordinator?.showDeviceDetails(deviceViewModel: deviceViewModel)
//        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width / 2) - 10
        return CGSize(width: width, height: 120)
    }
}


//przenieść
class ValuePresenceValidator: Validator {

    let fieldName: String

    init(fieldName: String) {
        self.fieldName = fieldName
    }

    func validate(text: String) -> ValidationError {
        if text.isEmpty {
            return "\(fieldName.capitalized) cannot be empty"
        } else {
            return nil
        }
    }

}


//to też
class MailValidator: Validator {

    func validate(text: String) -> ValidationError {
        if text.contains("@") {
            return nil
        } else {
            return "Invalid e-mail address"
        }
    }

}

