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

protocol HomeViewDelegate: AnyObject {
    func didTapButton()
}

protocol HomeViewProtocol {
    var delegate: HomeViewDelegate? { get set }

    func setupRecordLabel(_ record: Int)
}

final class HomeView: UIView, HomeViewProtocol {
    var delegate: HomeViewDelegate?

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "BEM VINDO(A)!"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var recordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("COMEÇAR", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [welcomeLabel, recordLabel, startButton])
        stack.spacing = 32
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        addViews()
    }

    private func addViews() {
        addSubview(contentStack)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 64),
            contentStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    @objc private func didTapButton() {
        delegate?.didTapButton()
    }


    func setupRecordLabel(_ record: Int) {
        recordLabel.text = "O record atual é: \(record)"
    }
}
