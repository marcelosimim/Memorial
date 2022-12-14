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
    var collectionView: UICollectionView { get set }
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

    private lazy var collectionHeader: TableHeader = {
        let tableHeader = TableHeader()
        tableHeader.translatesAutoresizingMaskIntoConstraints = false
        return tableHeader
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TableCell.self, forCellWithReuseIdentifier: TableCell.identifier)
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
        addSubview(collectionHeader)
        addSubview(collectionView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 64),
            welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            collectionHeader.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 64),
            collectionHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            collectionHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            collectionHeader.heightAnchor.constraint(equalToConstant: 50),

            collectionView.topAnchor.constraint(equalTo: collectionHeader.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
