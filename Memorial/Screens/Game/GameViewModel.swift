//
//  
//  GameViewModel.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/12/22.
//
//
import Foundation

protocol GameViewModelProtocol {
    var numberOfButtons: Int? { get set }
    var selectCell: ((Int) -> Void) { get set }
    var rightCellSelected: ((Int) -> Void) { get set }
    var wrongCellSelected: ((Int) -> Void) { get set }

    func startGame()
    func continueGame()
    func checkMove(_ button: Int)
}

final class GameViewModel: GameViewModelProtocol {
    var rightCellSelected: ((Int) -> Void) = { _ in }
    var wrongCellSelected: ((Int) -> Void) = { _ in }

    var numberOfButtons: Int?
    var selectCell: ((Int) -> Void) = { _ in }
    private var buttonSequence: [Int] = []
    private var userSequence: [Int] = []
    private var suportSequence: [Int] = []
    private lazy var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(showSequence), userInfo: nil, repeats: true)

    func startGame() {
        buttonSequence = []
        chooseCell()
    }

    func continueGame() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(showSequence), userInfo: nil, repeats: true)
        chooseCell()
    }

    func checkMove(_ button: Int) {
        if userSequence.first == button {
            rightCellSelected(button)
            userSequence.remove(at: 0)
            if userSequence.count == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.continueGame()
                }
            }
        } else {
            wrongCellSelected(button)
        }
    }

    private func chooseCell() {
        guard let numberOfButtons = numberOfButtons else { return }
        var randomIndex = Int.random(in: 0...numberOfButtons)

        if buttonSequence.count == numberOfButtons+1 { return }

        while numberAlreadyChosen(randomIndex) { randomIndex = Int.random(in: 0...numberOfButtons) }
        buttonSequence.append(randomIndex)
        userSequence = buttonSequence
        suportSequence = buttonSequence
        timer.fire()
    }

    private func numberAlreadyChosen(_ number: Int) -> Bool {
        buttonSequence.contains(number)
    }

    @objc private func showSequence() {
        if suportSequence.count > 0 {
            let nextButton = suportSequence.remove(at: 0)
            selectCell(nextButton)
        } else {
            timer.invalidate()
        }
    }
}
