//
//  OpenCageRequest.swift
//  Created on 6/9/21
//

import Combine
import Foundation

final class OpenCageRequest {
    static func search(term: String) -> AnyPublisher<OpenCageResponse, Error> {
        var request = URLRequest(url: Self.url)

        var queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: term)
        ]

        #if DEBUG
        // Pretty print JSON
        queryItems.append(URLQueryItem(name: "pretty", value: "1"))
        #endif
        request.url = request.url?.with(queryItems: queryItems)

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: OpenCageResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    private static var apiKey: String {
        "0c376b4aae614e929768fd46d4e8782c"
    }

    private static var url: URL {
        URL(string: "https://api.opencagedata.com/geocode/v1/json")!
    }
}
