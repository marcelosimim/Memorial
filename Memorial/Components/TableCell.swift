//
//  
//  TableCell.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/14/22.
//
//

import UIKit

class TableCell: UICollectionViewCell {
    static let identifier = "\(TableCell.self)"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        addViews()
        setupLayer()
    }

    private func setupLayer() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1).cgColor
    }

    private func addViews() {
        addSubview(titleLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func configure(_ text: String) {
        titleLabel.text = text
    }

    func configureAsTitle(_ text: String) {
        titleLabel.text = text
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
    }
}

