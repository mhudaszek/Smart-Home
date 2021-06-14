//
//  LoginViewController.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 15/06/2021.
//

import UIKit

class LoginViewController: ViewController {
    private let gradientView = GradientView()
    private let scrollView = InteractiveScrollView()
    private let titleLabel = UILabel()
    private let emailTextField = FormTextField()
    private let passwordTextField = FormTextField()
    private let loginButton = UIButton() //RoundedPinkButton()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.setCustomSpacing(30, after: titleLabel)
        stackView.setCustomSpacing(10, after: passwordTextField)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func loadView() {
        super.loadView()
        view = gradientView
        gradientView.set(gradientColors: [.shOrange2, .shOrangeRed2])
    }
    
    override func setup() {
        super.setup()
        addSubviews()
        setupCoordinates()
        setupViews()
    }
}

private extension LoginViewController {
    func bindViewModels() {

//        emailTextField.bind(viewModel: viewModel.emailFieldViewModel)
//        passwordTextField.bind(viewModel: viewModel.passwordFieldViewModel)
//        viewModel.loading.asDriver(onErrorJustReturn: false)
//            .drive(onNext: { [weak self] loading in
//                self?.setLoaderVisible(loading)
//            })
////            .drive(activityIndicator.rx.isAnimating)
//            .disposed(by: disposeBag)
    }

    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
    }
    
    func setupCoordinates() {
        view.activateConstraints(with: scrollView, left: 28, right: 28)
        scrollView.activateConstraints(with: stackView, top: 100, bottom: 150)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    func setupViews() {
        scrollView.visibleView = { view in self.loginButton}
    }
}

//pozmieniaj i przenieść
public extension UIColor {

    class var shOrange: UIColor {
        return UIColor(red: 236.0 / 255.0, green: 159.0 / 255.0, blue: 5.0 / 255.0, alpha: 1.0)
    }

    class var shOrangeRed: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 78.0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
    }
    ///
    class var shOrange2: UIColor {
        return UIColor(red: 245.0 / 255.0, green: 219.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
    }
    
    class var shOrangeRed2: UIColor {
        return UIColor(red: 243.0 / 255.0, green: 169.0 / 255.0, blue: 60 / 255.0, alpha: 1.0)
    }
//    243,169,60
    
    class var mqBlueberry: UIColor {
        return UIColor(red: 68.0 / 255.0, green: 71.0 / 255.0, blue: 145.0 / 255.0, alpha: 1.0)
    }

    class var mqBrightCyan: UIColor {
        return UIColor(red: 74.0 / 255.0, green: 210.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var mqPeachyPink: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 154.0 / 255.0, blue: 154.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var mqCoralPink: UIColor {
        return UIColor(red: 253.0 / 255.0, green: 84.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
    }
}


// to samo poprzerabiać?
//import Foundation

public class InteractiveScrollView: UIScrollView {

    public var visibleView: ((UIView) -> (UIView))?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        keyboardDismissMode = .interactive
        setupNotifications()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension InteractiveScrollView {
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardwillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardwillHide() {
        contentInset = .zero
        scrollIndicatorInsets = contentInset
    }

    @objc func keyboardDidShow(notification: NSNotification) {
        guard let firstResponder = findFirstResponder(for: self) else {
            return
        }
        guard let userInfo = notification.userInfo else {
            return
        }

        if let x = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            contentInset.bottom = x.size.height
            scrollIndicatorInsets = contentInset
        }
        DispatchQueue.main.async {
            if let customVisible = self.visibleView?(firstResponder) {
                let converted = customVisible.convert(customVisible.bounds, to: self)
                self.scrollRectToVisible(converted, animated: true)
            } else {
                let converted = firstResponder.convert(firstResponder.bounds, to: self)
                self.scrollRectToVisible(converted, animated: true)
            }
        }
    }

    func findFirstResponder(for view: UIView) -> UIView? {
        if view.isFirstResponder {
            return view
        }

        for  v in view.subviews {
            if v.isFirstResponder {
                return v
            } else {
                if let x = findFirstResponder(for: v) {
                    return x
                }
            }
        }
        return nil
    }
}

