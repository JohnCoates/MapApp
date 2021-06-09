//
//  ResultView.swift
//  6/9/21
//

import UIKit
import WebKit

final class ResultView: ProgrammaticView {
    let webView = WKWebView(frame: .zero)

    // MARK: - Setup

    override func configure() {
        backgroundColor = .white
    }

    override func addSubviews() {
        addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
    }

    override func addConstraints() {
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.widthAnchor.constraint(equalTo: widthAnchor),
            webView.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}
