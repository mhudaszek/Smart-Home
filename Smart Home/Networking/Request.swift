//
//  Request.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 11/03/2021.
//

import Foundation

protocol Request {
    associatedtype Response: Decodable

    var url: String { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var headers: HTTPHeaders { get set }

    func json(from data: Data) -> Response?
}

extension Request {
    var body: Data? {
        return nil
    }

    func json(from data: Data) -> Response? {
        return data.parseJSON()
    }
}

