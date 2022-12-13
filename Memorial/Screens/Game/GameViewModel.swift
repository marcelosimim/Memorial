//
//  
//  GameViewModel.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/12/22.
//
//
import Foundation
import RxRelay

protocol GameViewModelProtocol {
    var numberOfButtons: Int { get set }
    var numberOfHits: Int { get }
    var selectCell: PublishRelay<Int> { get }
    var rightCellSelected: PublishRelay<Int> { get }
    var wrongCellSelected: PublishRelay<Int> { get }

    func start()
    func next()
    func resume()
    func playBack()
    func pause()
    func checkMove(_ button: Int)
}

final class GameViewModel: GameViewModelProtocol {
    private let userRecord = UserRecord()
    private var timer: Timer?
    private var buttonSequence: [Int] = []
    private var userSequence: [Int] = []
    private var suportSequence: [Int] = []
    private var didUsePlayBack = false

    var numberOfHits = 0
    var numberOfButtons = 0
    var selectCell = PublishRelay<Int>()
    var rightCellSelected = PublishRelay<Int>()
    var wrongCellSelected = PublishRelay<Int>()

    func start() {
        didUsePlayBack = false
        setTimer()
        buttonSequence = []
        chooseCell()
    }

    func next() {
        numberOfHits += 1
        setTimer()
        chooseCell()
    }

    func pause() {
        guard let timer = timer else { return }
        timer.invalidate()
    }

    func resume() {
        setTimer()
        showSequence()
    }

    func playBack() {
        if !didUsePlayBack {
            suportSequence = buttonSequence
            setTimer()
            showSequence()
        }
        didUsePlayBack = true
    }

    func checkMove(_ button: Int) {
        if userSequence.first == button {
            rightCellSelected.accept(button)
            userSequence.remove(at: 0)
            if userSequence.count == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                    guard let self = self else { return }
                    self.next()
                }
            }
        } else {
            wrongCellSelected.accept(button)
            saveRecord()
        }
    }

    private func chooseCell() {
        guard let timer = timer else { return }
        var randomIndex = Int.random(in: 0...numberOfButtons-1)
        if buttonSequence.count == numberOfButtons { return }

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
        guard let timer = timer else { return }
        if suportSequence.count > 0 {
            let nextButton = suportSequence.remove(at: 0)
            selectCell.accept(nextButton)
        } else { timer.invalidate() }
    }

    private func saveRecord() {
        if numberOfHits > userRecord.currentRecord {
            userRecord.setRecord(numberOfHits)
        }
    }

    private func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(showSequence), userInfo: nil, repeats: true)
    }
}
