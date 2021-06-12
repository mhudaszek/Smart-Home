//
//  LocationDataDTO.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 12/06/2021.
//

import Foundation

struct Summary: Codable {
    let queryTime: Int
    let numResults: Int
}

struct BoundingBox: Codable {
    let northEast: String
    let southWest: String
    let entity: String
}

struct Address: Codable {
    let buildingNumber: String
    let streetNumber: String
    let routeNumbers: [String]
    let street: String
    let streetName: String
    let streetNameAndNumber: String
    let countryCode: String
    let countrySubdivision: String
    let countrySecondarySubdivision: String
    let municipality: String
    let postalCode: String
    let municipalitySubdivision: String
    let country: String
    let countryCodeISO3: String
    let freeformAddress: String
    let boundingBox: BoundingBox
    let localName: String
}

struct Addresses: Codable {
    let address: Address
    let position: String
}

struct LocationDataDTO: Codable {
    let summary: Summary
    let addresses: [Addresses]
}
