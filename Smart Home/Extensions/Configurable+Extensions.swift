//
//  Configurable+Extensions.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 04/03/2021.
//


import Foundation

protocol Configurable {}

extension Configurable {
    @discardableResult
    func configure(_ configuration: (Self) throws -> Void) rethrows -> Self {
        try configuration(self)
        return self
    }
}

extension NSObject: Configurable {}
