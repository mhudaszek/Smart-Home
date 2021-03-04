//
//  NetworkError.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 11/03/2021.
//

import Foundation

public enum NetworkError: LocalizedError {
    case invalidURL(url: String)
    case incorrectData
    case unknown

    public var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "Invalid URL: \(url)"
        case .incorrectData:
            return "The operation couldn’t be completed. Got incorrect data"
        case .unknown:
            return "The operation couldn’t be completed. Unknown reason"
        }
    }
}
