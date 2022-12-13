//
//  
//  ConfigurationView.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/13/22.
//
//

import Foundation
import UIKit
import RxRelay

protocol ConfigurationViewProtocol {
    var collectionView: UICollectionView { get set }
    var multiplier: BehaviorRelay<Double> { get }
    var slider: UISlider { get }
}

final class ConfigurationView: UIView, ConfigurationViewProtocol {
    var multiplier = BehaviorRelay(value: 1.0)

    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 2.9
        slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

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
        addSubview(slider)
        addSubview(collectionView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),

            collectionView.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    @objc private func changeValue() {
        let step: Float = 0.3
        let roundedValue = round(slider.value / step) * step
        slider.value = roundedValue
        multiplier.accept(Double(slider.value))
    }
}
