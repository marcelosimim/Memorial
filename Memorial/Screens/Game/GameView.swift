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
    func setupTime(_ time: Int)
    func setupLevel(_ level: Int)
}

final class GameView: UIView, GameViewProtocol {
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var recordLabel: UILabel = {
        let label = UILabel()
        label.text = "Record atual: \(UserRecord().currentRecord)"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        addSubview(timeLabel)
        addSubview(levelLabel)
        addSubview(recordLabel)
        addSubview(collectionView)
        addSubview(pauseImage)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            levelLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            levelLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            recordLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            recordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            collectionView.topAnchor.constraint(equalTo: levelLabel.bottomAnchor),
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

    func setupTime(_ time: Int) {
        if time >= 3600 {
            timeLabel.text = "Tempo percorrido: \(String(format: "%.2f", Double(time)/3600.0)) horas"
        }
        else if time >= 60 {
            timeLabel.text = "Tempo percorrido: \(String(format: "%.2f", Double(time)/60.0)) minutos"
        } else {
            timeLabel.text = "Tempo percorrido: \(time) segundos"
        }
    }

    func setupLevel(_ level: Int) {
        levelLabel.text = "Level atual: \(level)"
    }
}
