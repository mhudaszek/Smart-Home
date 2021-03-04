//
//  Networking.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 11/03/2021.
//

import Foundation

enum NetworkResult<Success> {
    case success(Success)
    case failure(Data)
    case error(Error)
}

protocol Networking {
    func make<NetworkRequest: Request>(_ request: NetworkRequest, callback: @escaping (NetworkResult<NetworkRequest.Response>) -> Void)
}

protocol FoundationNetworking {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
