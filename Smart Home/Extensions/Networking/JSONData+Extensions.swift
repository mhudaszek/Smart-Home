//
//  JSONData+Extensions.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 11/03/2021.
//

import Foundation

extension Data {
    func parseJSON<T: Decodable>() -> T? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(customDateFormatter)
        return try? decoder.decode(T.self, from: self)
    }

    private var customDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-ddEEEEEHH:mm:ss.SSSZ"
        return formatter
    }
}
