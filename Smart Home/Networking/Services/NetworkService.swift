//
//  NetworkService.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 12/06/2021.
//

import Foundation

protocol NetworkService {}

extension NetworkService {
    func make<T: Decodable>(request: NetworkRequest, completion: @escaping (Result<T,Error>) -> Void) {
        let urlRequest = NSMutableURLRequest(url: URL(string: request.path)!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        URLSession.shared.dataTask(with: urlRequest as URLRequest) { (data, res, error) in
            if let error = error { completion(.failure(error)); return }
            completion( Result{ try JSONDecoder().decode(T.self, from: data!) })
        }.resume()
    }
}
