//
//  ProgrammaticView.swift
//

import UIKit

/// Subclasses should override the methods under the setup section
class ProgrammaticView: UIView {
    // MARK: - Init

    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable, message: "Override configure() instead")
    required init(coder aDecoder: NSCoder) {
        fatalError("Not defined")
    }

    func configure() {}
    func addSubviews() {}
    func addConstraints() {}
}

extension ProgrammaticView: ProgrammaticViewProtocol {}

protocol ProgrammaticViewProtocol {

    /// Configure view and any subviews
    func configure()

    func addSubviews()
    func addConstraints()
}

extension ProgrammaticViewProtocol {
    /// Runs all the setup functions
    func setup() {
        configure()
        addSubviews()
        addConstraints()
    }

    /// Configure view and any subviews
    func configure() {}

    func addSubviews() {}
    func addConstraints() {}
}
