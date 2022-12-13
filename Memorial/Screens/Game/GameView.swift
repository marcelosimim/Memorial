//
//  
//  GameView.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/12/22.
//
//

import Foundation
import UIKit

protocol GameViewProtocol {
    var collectionView: UICollectionView { get set }
}

final class GameView: UIView, GameViewProtocol {
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        addViews()
    }

    private func addViews() {
        addSubview(collectionView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
