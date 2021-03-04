//
//  HTTPHeaders.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 11/03/2021.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public extension HTTPHeaders {
    mutating func addContentType(_ contentType: HTTPContentType) {
        self["Content-Type"] = contentType.rawValue
    }

    static func defaultHeaders() -> HTTPHeaders {
        var headers = HTTPHeaders()
        headers.addContentType(.json)
        return headers
    }
}

public enum HTTPContentType: String {
    case json = "application/json"
}
