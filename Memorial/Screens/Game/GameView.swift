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

    func resume()
    func pause()
}

final class GameView: UIView, GameViewProtocol {
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var pauseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .pause
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemGray
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        addViews()
    }

    private func addViews() {
        addSubview(collectionView)
        addSubview(pauseImage)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),

            pauseImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            pauseImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            pauseImage.heightAnchor.constraint(equalToConstant: 200),
        ])
    }

    func resume() {
        pauseImage.isHidden = true
    }

    func pause() {
        pauseImage.isHidden = false
    }
}
