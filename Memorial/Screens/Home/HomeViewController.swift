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
        customView.delegate = self
        viewModelBinds()
        viewModel.setupRecord()
    }

    override func loadView() {
        super.loadView()
        view = customView as? UIView
    }

    private func viewModelBinds() {
        viewModel.record.bind { [weak self] record in
            guard let self = self else { return }
            self.customView.setupRecordLabel(record)
        }.disposed(by: disposeBag)

        viewModel.didFinishValidation.bind { [weak self] number in
            guard let self = self else { return }
            self.start(number)
        }.disposed(by: disposeBag)

        viewModel.didFinishValidationFailure.bind { [weak self] _ in
            guard let self = self else { return }
            self.showError()
        }.disposed(by: disposeBag)
    }

    private func start(_ number: Int) {
        let vc = ConfigurationViewController()
        // let vc = GameViewController(numberOfButtons: number)
        navigationController?.pushViewController(vc, animated: true)
    }

    private func showError() {
        let alert = UIAlertController(title: "Acima do número permitido", message: "Escolha no máximo \(CellConfiguration.customMaxElements()) botões", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapButton(_ text: String) {
        viewModel.verify(text)
    }
}
