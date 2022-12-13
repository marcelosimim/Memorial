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
        setupNavigationBar()
        setupCollectionView()
        setupNotificationCenter()
        viewModelBinds()
        startGame()
    }

    override func loadView() {
        super.loadView()
        view = customView as? UIView
    }

    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Opções", style: .plain, target: self, action: #selector(optionMenu))
    }

    private func setupCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
    }

    private func setupNotificationCenter() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
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
            self.showError()
        }.disposed(by: disposeBag)

        viewModel.numberOfHits.bind { [weak self] numberOfHits in
            self?.customView.setupLevel(numberOfHits)
        }.disposed(by: disposeBag)

        viewModel.time.bind { [weak self] time in
            self?.customView.setupTime(time)
        }.disposed(by: disposeBag)
    }

    private func startGame() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) { [weak self] in
            guard let self = self else { return }
            self.viewModel.start()
        }
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

    private func showError() {
        let alert = UIAlertController(title: "Botão errado!", message: "Seu máximo de botões foi: \(viewModel.numberOfHits)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reiniciar", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.startGame()
        }))
        alert.addAction(UIAlertAction(title: "Sair", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }

    @objc private func optionMenu() {
        viewModel.pause()
        customView.pause()
        let actionSheet = UIAlertController(title: "Opções", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Continuar", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.customView.resume()
            self.viewModel.resume()
        }))
        actionSheet.addAction(UIAlertAction(title: "Repetir", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.customView.resume()
            self.viewModel.playBack()
        }))
        actionSheet.addAction(UIAlertAction(title: "Reiniciar", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.customView.resume()
            self.startGame()
        }))
        actionSheet.addAction(UIAlertAction(title: "Sair", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }))
        present(actionSheet, animated: true)
    }
}

// MARK: - Collection View

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfButtons
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell else { fatalError() }
        cell.configure()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: CellConfiguration.customSize(), height: CellConfiguration.customSize())
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.checkMove(indexPath.row)
    }
}

// MARK: - App background and foreground
extension GameViewController {
    @objc func appMovedToBackground() {
        viewModel.pause()
    }

    @objc func appCameToForeground() {
        self.optionMenu()
    }
}
