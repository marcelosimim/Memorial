//
//  
//  HomeViewModel.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/12/22.
//
//
import Foundation

protocol HomeViewModelProtocol {
    var didFinishValidation: ((String) -> Void) { get set }
    var didFinishValidationFailure: ((String) -> Void) { get set }

    func verify(_ text: String)
}

final class HomeViewModel: HomeViewModelProtocol {
    var didFinishValidation: ((String) -> Void) = { _ in }
    var didFinishValidationFailure: ((String) -> Void) = { _ in }

    func verify(_ text: String) {
        didFinishValidation(text)
    }
}
