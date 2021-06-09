//
//  SearchTableViewCell.swift
//  Created on 6/9/21
//

import Combine
import UIKit

final class SearchTableViewCell: UITableViewCell, ProgrammaticViewProtocol {
    static let reuseIdentifier = String(describing: SearchTableViewCell.self)

    var result: OpenCageResponseResult? {
        didSet {
            hydrate()
        }
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Self.reuseIdentifier)
        setup()
    }

    required init(coder aDecoder: NSCoder) { fatalError("Not defined") }

    // MARK: - Updating

    private func hydrate() {
        guard let result = result else {
            productionPrint("Can't hydrate cell without a result")
            return
        }

        textLabel?.text = result.title
    }

    // MARK: - Sizing

    static let intrinsicContentHeight: CGFloat = 44

    override var intrinsicContentSize: CGSize {
        .init(width: UIView.noIntrinsicMetric, height: Self.intrinsicContentHeight)
    }
}
