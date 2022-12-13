//
//  
//  GameViewController.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/12/22.
//
//
import RxCocoa
import RxSwift
import UIKit

class GameViewController: UIViewController {
    private lazy var customView: GameViewProtocol = GameView()
    private lazy var viewModel: GameViewModelProtocol = GameViewModel()
    private let disposeBag = DisposeBag()

    init(numberOfButtons: Int) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel.numberOfButtons = numberOfButtons
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupCollectionView()
        viewModelBinds()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            self.viewModel.startGame()
        }
    }

    override func loadView() {
        super.loadView()
        view = customView.view
    }

    private func setupCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
    }

    private func viewModelBinds() {
        viewModel.selectCell.bind { [weak self] row in
            guard let self = self else { return }
            self.highlightCell(row)
        }.disposed(by: disposeBag)

        viewModel.rightCellSelected.bind { [weak self] row in
            guard let self = self else { return }
            self.rightCell(row)
        }.disposed(by: disposeBag)

        viewModel.wrongCellSelected.bind { [weak self] row in
            guard let self = self else { return }
            self.wrongCell(row)
        }.disposed(by: disposeBag)
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
        viewModel.numberOfButtons
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
