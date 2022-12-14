//
//  
//  HomeView.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/12/22.
//
//

import Foundation
import UIKit

protocol HomeViewProtocol {
    var tableView: UITableView { get set }
}

final class HomeView: UIView, HomeViewProtocol {
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "BEM VINDO(A)!"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var tableView: UITableView = {
        let collectionView = UITableView()
        collectionView.register(TableRow.self, forCellReuseIdentifier: TableRow.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        addViews()
    }

    private func addViews() {
        addSubview(welcomeLabel)
        addSubview(tableView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 64),
            welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            tableView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 64),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
