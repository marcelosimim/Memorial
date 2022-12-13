//
//  
//  GameViewController.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/12/22.
//
//
import UIKit

class GameViewController: UIViewController {
    private lazy var customView: GameViewProtocol = GameView()
    private lazy var viewModel: GameViewModelProtocol = GameViewModel()
    private let numberOfButtons: Int

    init(numberOfButtons: Int) {
        self.numberOfButtons = numberOfButtons
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        viewModel.numberOfButtons = numberOfButtons
        viewModel.selectCell = { row in
            self.highlightCell(row)
        }
        viewModel.rightCellSelected = { row in
            self.rightCell(row)
        }
        viewModel.wrongCellSelected = { row in
            self.wrongCell(row)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            self.viewModel.startGame()
        }
    }

    override func loadView() {
        super.loadView()
        view = customView.view
    }


    private func highlightCell(_ row: Int) {
        guard let cell = customView.collectionView.cellForItem(at: IndexPath(row: row, section: 0)) as? ButtonCell else { return }
        cell.highlightCell()
    }

    private func rightCell(_ row: Int) {
        guard let cell = customView.collectionView.cellForItem(at: IndexPath(row: row, section: 0)) as? ButtonCell else { return }
        cell.rightCell()
    }

    private func wrongCell(_ row: Int) {
        guard let cell = customView.collectionView.cellForItem(at: IndexPath(row: row, section: 0)) as? ButtonCell else { return }
        cell.wrongCell()
    }
}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfButtons
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell else { fatalError() }
        cell.configure()
        cell.tag = indexPath.row
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 60, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.checkMove(indexPath.row)
    }
}
