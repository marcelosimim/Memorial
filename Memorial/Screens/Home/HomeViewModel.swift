//
//  
//  HomeViewModel.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/12/22.
//
//
import CoreData
import Foundation
import RxRelay

protocol HomeViewModelProtocol {
    // var rounds: [NSManagedObject] { get }
    var rounds: BehaviorRelay<[Round]> { get }
    func fetchRounds()
}

final class HomeViewModel: HomeViewModelProtocol {
    var rounds: BehaviorRelay<[Round]> = BehaviorRelay(value: [])

    // var rounds: [NSManagedObject] = []

    func fetchRounds() {
        rounds.accept(GameDataManager.shared.fetchRounds())
        // rounds = GameDataManager.shared.fetchRounds()
    }
}
