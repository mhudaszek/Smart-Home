//
//  HomeViewController.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 03/03/2021.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: ViewController {
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

    private let viewModel: HomeViewModel
    private var disposeBag = DisposeBag()

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
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
        viewModel.fetchCurrentWeather()
        setupRx()
    }
}

private extension HomeViewController {
    func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(underlineSwitchView)
//        view.activateConstraints(with: collectionView, left: 20, right: 20)
    }

    func setupLayout() {
        underlineSwitchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underlineSwitchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            underlineSwitchView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            underlineSwitchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            underlineSwitchView.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            underlineSwitchView.heightAnchor.constraint(equalToConstant: 50),

            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
