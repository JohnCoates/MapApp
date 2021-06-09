//
//  URL+QueryItems.swift
//  Created on 6/9/21
//

import Foundation

extension URL {
    func with(queryItems: [URLQueryItem]) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            fatalError("Failed to create URLComponents from: \(self)")
        }

        components.queryItems = queryItems
        guard let url = components.url else {
            fatalError("Failed to create url from: \(components)")
        }
        return url
    }
}
