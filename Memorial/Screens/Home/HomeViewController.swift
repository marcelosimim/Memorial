//
//  
//  HomeViewController.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/12/22.
//
//
import UIKit

class HomeViewController: UIViewController {
    private lazy var customView: HomeViewProtocol = HomeView()
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        viewModelBinds()
    }

    override func loadView() {
        super.loadView()
        view = customView.view
    }

    private func viewModelBinds() {
        viewModel.didFinishValidation = { [weak self] number in
            self?.start(number)
        }
    }

    private func start(_ number: String) {
       print(number)
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapButton(_ text: String) {
        viewModel.verify(text)
    }
}
