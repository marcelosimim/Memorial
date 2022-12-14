//
//  TableHeader.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/14/22.
//

import UIKit

class TableRow: UITableViewCell {
    static let identifier = "\(TableRow.self)"
    private lazy var elementTableCell: TableCell = {
        let tableCell = TableCell()
        tableCell.configure("Elementos")
        tableCell.translatesAutoresizingMaskIntoConstraints = false
        return tableCell
    }()

    private lazy var levelTableCell: TableCell = {
        let tableCell = TableCell()
        tableCell.configure("Level")
        tableCell.translatesAutoresizingMaskIntoConstraints = false
        return tableCell
    }()

    private lazy var timeTableCell: TableCell = {
        let tableCell = TableCell()
        tableCell.configure("Tempo")
        tableCell.translatesAutoresizingMaskIntoConstraints = false
        return tableCell
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [elementTableCell, levelTableCell, timeTableCell])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        addViews()
    }

    private func addViews() {
        addSubview(stackView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(_ model: Round) {
        elementTableCell.configure("\(model.elements)")
        levelTableCell.configure("\(model.level)")
        timeTableCell.configure("\(model.time)")
    }

    func configure(_ titles: [String]) {
        if titles.count == 3 {
            elementTableCell.configureAsTitle(titles[0])
            levelTableCell.configureAsTitle(titles[1])
            timeTableCell.configureAsTitle(titles[2])
        }
    }
}
