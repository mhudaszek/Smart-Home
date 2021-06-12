//
//  WeatherView.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 12/06/2021.
//

import UIKit
import Kingfisher

class WeatherView: View {
    private let weatherIconView = UIImageView()
    private let cityNameLabel = UILabel().configure {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let weatherDescriptionLabel = UILabel().configure {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let pressureLabel = UILabel().configure {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let tempLabel = UILabel().configure {
        $0.textAlignment = .right
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 35)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func setup() {
        super.setup()
        addSubviews()
        setupConstraints()
    }
    
    func setupView(with model: WeatherModel) {
        weatherIconView.kf.setImage(with: URL(string: model.weatherIconUrl))
        cityNameLabel.text = model.cityName
        weatherDescriptionLabel.text = model.weatherDescription
        pressureLabel.text = model.pressure
        tempLabel.text = model.temperature
    }
}

private extension WeatherView {
    func addSubviews() {
        addSubview(weatherIconView)
        addSubview(stackView)
        stackView.addArrangedSubview(cityNameLabel)
        stackView.addArrangedSubview(weatherDescriptionLabel)
        stackView.addArrangedSubview(pressureLabel)
        addSubview(tempLabel)
    }
    
    func setupConstraints() {
        weatherIconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherIconView.widthAnchor.constraint(equalToConstant: 100),
            weatherIconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherIconView.topAnchor.constraint(equalTo: topAnchor),
            weatherIconView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: weatherIconView.trailingAnchor, constant: 20),
            stackView.centerYAnchor.constraint(equalTo: weatherIconView.centerYAnchor),
            
            tempLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor),
            tempLabel.topAnchor.constraint(equalTo: topAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tempLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
