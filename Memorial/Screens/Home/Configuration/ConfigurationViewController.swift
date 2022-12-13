//
//  
//  ConfigurationViewController.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/13/22.
//
//
import UIKit
import RxSwift
import RxCocoa

class ConfigurationViewController: UIViewController {
    private lazy var customView: ConfigurationViewProtocol = ConfigurationView()
    private lazy var viewModel: ConfigurationViewModelProtocol = ConfigurationViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        viewModelBinds()
    }

    override func loadView() {
        super.loadView()
        view = customView as? UIView
    }

    private func setupCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Resetar recorde", style: .plain, target: self, action: #selector(resetRecord))
    }

    private func viewModelBinds() {
        customView.multiplier.bind { [weak self] multiplier in
            guard let self = self else { return }
            self.customView.collectionView.reloadData()
            self.viewModel.changeCellConfigurator(collection: self.customView.collectionView.frame, multiplier: multiplier)
        }.disposed(by: disposeBag)
    }

    @objc private func resetRecord() {
        viewModel.resetRecord()
    }
}

extension ConfigurationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        50
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
}
