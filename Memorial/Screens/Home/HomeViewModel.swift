//
//  
//  HomeViewModel.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/12/22.
//
//
import Foundation
import RxRelay

protocol HomeViewModelProtocol {
    var didFinishValidation: PublishRelay<Int> { get }
    var didFinishValidationFailure: PublishRelay<Void> { get }
    var record: PublishRelay<Int> { get }

    func verify(_ text: String)
    func setupRecord()
}

final class HomeViewModel: HomeViewModelProtocol {
    private let userRecord = UserRecord()
    var didFinishValidation = PublishRelay<Int>()
    var didFinishValidationFailure = PublishRelay<Void>()
    var record = PublishRelay<Int>()

    func verify(_ text: String) {
        guard let number = Int(text) else { return }
        if number <= CellConfiguration.maxElements() {
            didFinishValidation.accept(number)
        } else {
            didFinishValidationFailure.accept(())
        }
    }

    func setupRecord() {
        print(UIScreen.main.bounds.height)
        record.accept(userRecord.currentRecord)
    }
}
