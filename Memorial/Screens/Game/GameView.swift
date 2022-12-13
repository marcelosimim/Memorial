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
    var view: UIView { get }
    var collectionView: UICollectionView { get set }
}

final class GameView: GameViewProtocol {
    var view = UIView()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    init() {
        view.backgroundColor = .white
        addViews()
    }

    private func addViews() {
        view.addSubview(collectionView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
