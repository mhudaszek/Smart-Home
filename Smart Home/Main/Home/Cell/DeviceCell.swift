//
//  DeviceCell.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 11/03/2021.
//

import UIKit

class DeviceCell: CollectionViewCell {
    private var titleLabel = UILabel().configure {
        $0.font = .systemFont(ofSize: 17, weight: .bold)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private var switchButton = UIButton().configure {
        $0.addTarget(self, action: #selector(switchDeviceTapped), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private var deviceImageView = UIImageView().configure {
        $0.image = #imageLiteral(resourceName: "bulbIconOn")
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override func setupProperties() {
        super.setupProperties()
        setupView()
    }

    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        addSubview(titleLabel)
        addSubview(switchButton)
        addSubview(deviceImageView)
    }

    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        layoutSwitchButton()
        layoutTitleLabel()
        layoutDeviceImageView()
    }

    func setup(with viewModel: DeviceCellViewModel) {
        titleLabel.text = viewModel.device.title
    }
}

private extension DeviceCell {
    @objc func switchDeviceTapped() {
//        guard let viewModel = viewModel as? SwitchDeviceViewModel else { return }
//        viewModel.updateSwitchState()
//        switchButton.setImage(UIImage(named: viewModel.switchIcon), for: .normal)
    }
}

private extension DeviceCell {
    func setupView() {
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.9)

        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }

    func layoutTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: switchButton.leadingAnchor, constant: -10)
        ])
    }

    func layoutSwitchButton() {
        NSLayoutConstraint.activate([
            switchButton.widthAnchor.constraint(equalToConstant: 25),
            switchButton.heightAnchor.constraint(equalToConstant: 25),
            switchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            switchButton.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        ])
    }

    func layoutDeviceImageView() {
        NSLayoutConstraint.activate([
            deviceImageView.widthAnchor.constraint(equalToConstant: 40),
            deviceImageView.heightAnchor.constraint(equalToConstant: 40),
            deviceImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            deviceImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
}
