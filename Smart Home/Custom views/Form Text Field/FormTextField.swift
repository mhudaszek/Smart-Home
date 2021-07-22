//
//  FormTextField.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 13/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

class FormTextField: View {
    private let inputFieldHeight: CGFloat = 50.0

    private let disposeBag = DisposeBag()
    private lazy var inputFieldView = UIView()
    private lazy var errorLabel = InsetedUILabel()
    private lazy var fieldIcon = UIImageView()
    private lazy var textField = UITextField()

    public var secureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = secureTextEntry
        }
    }

    override func setup() {
        super.setup()
        setupView()
    }
    
    func hideKeyboard() {
        textField.resignFirstResponder()
    }

    func bind(viewModel: FormTextFieldViewModel) {
        fieldIcon.image = viewModel.image
        textField.isSecureTextEntry = viewModel.isSecureTextEntry
        textField.attributedPlaceholder = AttributedStringBuilder.make(text: viewModel.placeholderText, textColor: UIColor.white.withAlphaComponent(0.5), font: UIFont.systemFont(ofSize: 15))

        textField.rx.text.orEmpty
            .bind(to: viewModel.text)
            .disposed(by: disposeBag)

        viewModel.error.asDriver(onErrorJustReturn: nil)
            .drive(errorLabel.rx.text)
            .disposed(by: disposeBag)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if inputFieldView.hitTest(point, with: event) != nil {
            return textField
        } else {
            return super.hitTest(point, with: event)
        }
    }
}

private extension FormTextField {
    func setupView() {
        addSubviews()
        setupConstraints()
        setupInputFieldView()
        setupErrorLabel()
        setupFieldIcon()
        setupTextField()
        setupRx()
    }

    private func setupRx() {
        let editingBeginObservable = textField.rx.controlEvent(.editingDidBegin).map { true }.asObservable()
        let editingEndObservable = textField.rx.controlEvent(.editingDidEnd).map { false }.asObservable()

        Observable.merge(editingBeginObservable, editingEndObservable).subscribe(onNext: { [weak self] editing in
            self?.toggleBorder(show: editing)
        })
        .disposed(by: disposeBag)
    }
    
    func toggleBorder(show: Bool) {
        let borderColorAnim = CABasicAnimation(keyPath: "borderColor")

        borderColorAnim.fromValue = (show ? UIColor.clear.cgColor : UIColor.white.cgColor)
        borderColorAnim.toValue = (show ? UIColor.white.cgColor : UIColor.clear.cgColor)
        borderColorAnim.duration = 0.6
        borderColorAnim.isRemovedOnCompletion = false
        borderColorAnim.fillMode = CAMediaTimingFillMode.forwards

        inputFieldView.layer.add(borderColorAnim, forKey: "")
    }

    func addSubviews() {
        addSubview(inputFieldView)
        inputFieldView.addSubview(fieldIcon)
        inputFieldView.addSubview(textField)
        addSubview(errorLabel)
    }
    
    func setupConstraints() {
        inputFieldView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        fieldIcon.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputFieldView.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputFieldView.topAnchor.constraint(equalTo: topAnchor),
            inputFieldView.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputFieldView.heightAnchor.constraint(equalToConstant: inputFieldHeight),
            
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.topAnchor.constraint(equalTo: inputFieldView.bottomAnchor, constant: 4),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            fieldIcon.heightAnchor.constraint(equalToConstant: 25),
            fieldIcon.widthAnchor.constraint(equalToConstant: 25),
            fieldIcon.centerYAnchor.constraint(equalTo: inputFieldView.centerYAnchor),
            fieldIcon.leadingAnchor.constraint(equalTo: inputFieldView.leadingAnchor, constant: 18),
            
            textField.centerYAnchor.constraint(equalTo: inputFieldView.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: fieldIcon.trailingAnchor, constant: 9),
            textField.trailingAnchor.constraint(equalTo: inputFieldView.trailingAnchor, constant: 18)
        ])
    }

    func setupInputFieldView() {
        inputFieldView.translatesAutoresizingMaskIntoConstraints = false
//        inputFieldView.snp.makeConstraints { (make) in
//            make.height.equalTo(inputFieldHeight)
//            make.leading.trailing.top.equalToSuperview()
//        }
        inputFieldView.layer.cornerRadius = inputFieldHeight / 2
        inputFieldView.layer.borderWidth = 1
        inputFieldView.layer.borderColor = UIColor.clear.cgColor
        inputFieldView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
    }

    func setupErrorLabel() {
        errorLabel.textColor = .red
        errorLabel.font = UIFont.systemFont(ofSize: 13)
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.insets = UIEdgeInsets(top: 4.0, left: 0, bottom: 4.0, right: 0)
//        errorLabel.snp.makeConstraints { (make) in
//            make.leading.trailing.bottom.equalToSuperview()
//            make.top.equalTo(inputFieldView.snp.bottom).offset(4.0)
//        }
    }

    func setupFieldIcon() {
//        fieldIcon.snp.makeConstraints { (make) in
//            make.height.width.equalTo(25.0)
//            make.centerY.equalToSuperview()
//            make.leading.equalTo(18.0)
//        }
    }

    func setupTextField() {
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = .black//.white
        textField.tintColor = .black//.white
        textField.autocapitalizationType = .none
        
//        textField.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.leading.equalTo(fieldIcon.snp.trailing).offset(9.0)
//            make.trailing.equalToSuperview().inset(18.0)
//        }

    }
}

//przeniesc
class InsetedUILabel: UILabel {
    var insets: UIEdgeInsets = .zero {
        didSet {
            setNeedsDisplay()
        }
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += insets.left + insets.right
        size.height += insets.top + insets.bottom
        return size
    }
}

//przeniesc
public class AttributedStringBuilder {
    public class func make(text: String, textColor: UIColor, font: UIFont? = nil) -> NSAttributedString {
        var attributes = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        if let font = font {
            attributes[NSAttributedString.Key.font] = font
        }
        return NSAttributedString(string: text, attributes: attributes)
    }
}
