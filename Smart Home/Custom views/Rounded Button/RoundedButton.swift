//
//  RoundedButton.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 23/06/2021.
//

import UIKit

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {}

    func transitionToColor(_ color: UIColor, duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, animations: {
            self.backgroundColor = color
        })
    }
}

class RoundedPinkButton: Button {
    func setTitle(_ title: String) {
        let attributedTitleStateNormal = AttributedStringBuilder.make(text: title, textColor: .white,
                                                                      font: UIFont.systemFont(ofSize: 15))
        //UIFont.mqButtonTitleFont()
        let attributedTitleStatePressed = AttributedStringBuilder.make(text: title,
                textColor: UIColor.white.withAlphaComponent(0.5), font: UIFont.systemFont(ofSize: 15))
//        UIFont.mqButtonTitleFont()
        setAttributedTitle(attributedTitleStateNormal, for: UIControl.State())
        setAttributedTitle(attributedTitleStatePressed, for: .highlighted)
    }

    override func setup() {
        super.setup()
        backgroundColor = .brownishGrey //.dark //.mqCoralPink
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.size.height / 2
    }
}
