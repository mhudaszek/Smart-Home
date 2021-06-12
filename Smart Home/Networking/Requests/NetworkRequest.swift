//
//  NetworkRequest.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 12/06/2021.
//

import Foundation

protocol NetworkRequest {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
}
