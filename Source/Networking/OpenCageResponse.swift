//
//  OpenCageResponse.swift
//  Created on 6/9/21
//

import Foundation

struct OpenCageResponse: Decodable {
    let rate: OpenCageResponseRateLimit
    let results: [OpenCageResponseResult]
}

struct OpenCageResponseResult: Decodable {
    let title: String
    let annotations: OpenCageResponseResultAnnotations
    enum CodingKeys: String, CodingKey {
        case annotations
        case title = "formatted"
    }
}

struct OpenCageResponseResultAnnotations: Decodable {
    let openStreetMap: OpenStreetMap

    struct OpenStreetMap: Decodable {
        let url: String
    }

    enum CodingKeys: String, CodingKey {
        case openStreetMap = "OSM"
    }
}

struct OpenCageResponseRateLimit : Decodable {
    let limit: Int
    let remaining: Int
    let resetAtTimestamp: Int

    enum CodingKeys: String, CodingKey {
        case limit, remaining
        case resetAtTimestamp = "reset"
    }
}
