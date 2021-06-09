//
//  ResultViewModel.swift
//  6/9/21
//

import Combine
import Foundation

final class ResultViewModel {
    var result: OpenCageResponseResult? {
        didSet { hydrate() }
    }

    @Published var title: String = ""
    @Published var webViewUrl: URL?

    private var subscriptions = [AnyCancellable]()

    private func hydrate() {
        guard let result = result else {
            productionPrint("Missing result for view model hydration")
            return
        }
        
        title = result.title
        webViewUrl = URL(string: result.annotations.openStreetMap.url)
    }
}
