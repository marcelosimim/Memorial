//
//  ButtonCell.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/12/22.
//

import UIKit

class ButtonCell: UICollectionViewCell {
    static let identifier = "\(ButtonCell.self)"

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayer()
    }

    private func setupLayer() {
        layer.cornerRadius = 12
    }

    private func defaultColor() {
        backgroundColor = .systemGray4
    }

    func configure() {
        defaultColor()
    }

    func highlightCell() {
        backgroundColor = .systemBlue
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.defaultColor()
        }
    }

    func rightCell() {
        backgroundColor = .systemGreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.defaultColor()
        }
    }

    func wrongCell() {
        backgroundColor = .systemRed
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.defaultColor()
        }
    }
}
