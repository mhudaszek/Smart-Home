//
//  DevicesRequest.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 11/03/2021.
//

import Foundation

struct DevicesRequest: Request {
    typealias Response = OpenGateResponse

    var method: HTTPMethod {
        return .get
    }

    var url: String {
        return "/gpio/" //Constants.baseURL +
    }

    let body: Data? = nil
    var headers: HTTPHeaders = [:]
}
