//
//  
//  HomeViewController.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/12/22.
//
//
import RxCocoa
import RxSwift
import UIKit

class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private lazy var customView: HomeViewProtocol = HomeView()
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        viewModelBinds()
        viewModel.setupRecord()
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
    }

    override func loadView() {
        super.loadView()
        view = customView as? UIView
    }

    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Configurações", style: .plain, target: self, action: #selector(didTapConfiguration))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Jogar", style: .plain, target: self, action: #selector(start))
    }

    private func viewModelBinds() {
        viewModel.record.bind { [weak self] record in
            guard let self = self else { return }
        }.disposed(by: disposeBag)
    }

    @objc private func start() {
        let vc = GameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }


    @objc private func didTapConfiguration() {
        navigationController?.pushViewController(ConfigurationViewController(), animated: true)
    }
}

// MARK: - Collection View

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCell.identifier, for: indexPath) as? TableCell else { fatalError() }
        cell.configure("teste")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/3, height: 50)
    }
}
