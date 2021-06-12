//
//  ObservableType+WithPrevious.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 18/04/2021.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableConvertibleType {
    func subscribe<Owner>(with owner: Owner,
                          onNext: ((Owner, Element) -> Void)? = nil,
                          onError: ((Owner, Swift.Error) -> Void)? = nil,
                          onCompleted: ((Owner) -> Void)? = nil,
                          onDisposed: (() -> Void)? = nil) -> Disposable where Owner: AnyObject {
        weak var weakOwner = owner
        return self.asObservable()
            .subscribe { value in
                guard let owner = weakOwner else { return }
                onNext?(owner, value)
            } onError: { error in
                guard let owner = weakOwner else { return }
                onError?(owner, error)
            } onCompleted: {
                guard let owner = weakOwner else { return }
                onCompleted?(owner)
            } onDisposed: {
                onDisposed?()
            }
    }
}

