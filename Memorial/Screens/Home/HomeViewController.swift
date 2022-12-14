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
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        viewModelBinds()
        viewModel.fetchRounds()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchRounds()
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
        viewModel.rounds.bind { [weak self] _ in
            guard let self = self else { return }
            self.customView.collectionView.reloadData()
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rounds.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableRow.identifier, for: indexPath) as? TableRow else { fatalError() }
        cell.configure(viewModel.rounds.value[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = TableRow()
        header.configure(["Elementos", "Level", "Tempo"])
        return header
    }
}
