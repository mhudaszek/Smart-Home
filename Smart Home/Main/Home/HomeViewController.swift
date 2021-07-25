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
    private let activityIndicator = UIActivityIndicatorView().configure {
        $0.style = .large
        $0.color = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

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
        viewModel.fetch()
        setupRx()
    }
}

private extension HomeViewController {
    func addSubviews() {
        view.addSubview(weatherView)
        view.addSubview(collectionView)
        view.addSubview(underlineSwitchView)
        view.addSubview(activityIndicator)
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

            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
        viewModel.inProgress
            .subscribe(with: self, onNext: { owner, isLoading in
                isLoading
                    ? owner.activityIndicator.startAnimating()
                    : owner.activityIndicator.stopAnimating()
                owner.underlineSwitchView.isHidden = isLoading
                guard let weatherModel = owner.viewModel.weatherModel else { return }
                owner.weatherView.setupView(with: weatherModel)
                owner.collectionView.reloadData()
            }).disposed(by: disposeBag)
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
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width / 2) - 10
        return CGSize(width: width, height: 120)
    }
}
