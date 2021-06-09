//
//  SearchView.swift
//  6/9/21
//

import UIKit

final class SearchView: ProgrammaticView {
    let tableView = UITableView(frame: .zero, style: .plain)

    // MARK: - Setup

    override func configure() {
        backgroundColor = .white

        tableView.backgroundColor = backgroundColor
        tableView.separatorStyle = .none
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
    }

    override func addSubviews() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    override func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.widthAnchor.constraint(equalTo: widthAnchor),
            tableView.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}
