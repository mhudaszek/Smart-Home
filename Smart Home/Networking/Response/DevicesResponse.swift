//
//  DevicesResponse.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 11/03/2021.
//

import Foundation

//struct DevicesResponse: Decodable {
//
//}

public typealias ResultMap = [String: Any?]

struct Device {
    let id: Int?
    let title: String?

    init(_ resultMap: ResultMap) {
        self.id = resultMap["id"] as? Int
        self.title = resultMap["title"] as? String
    }
}

struct DevicesResponse {
    var devices: [Device]?

    init(_ resultMap: [ResultMap]) {
        self.devices = resultMap.map { Device($0) }
    }
}
