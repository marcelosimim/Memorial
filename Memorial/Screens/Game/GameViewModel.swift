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
    var numberOfHits: BehaviorRelay<Int> { get }
    var record: BehaviorRelay<Int> { get }
    var time: BehaviorRelay<Int> { get }
    var selectCell: PublishRelay<Int> { get }
    var rightCellSelected: PublishRelay<Int> { get }
    var wrongCellSelected: PublishRelay<Int> { get }

    func start()
    func next()
    func resume()
    func playBack()
    func pause()
    func checkMove(_ button: Int)
    func recoverRecord()
}

final class GameViewModel: GameViewModelProtocol {
    private let gameDataManager = GameDataManager.shared
    private var gameTimer: Timer?
    private var roundTimer: Timer?
    private var buttonSequence: [Int] = []
    private var userSequence: [Int] = []
    private var suportSequence: [Int] = []
    private var didUsePlayBack = false

    var numberOfHits = BehaviorRelay(value: 0)
    var numberOfButtons = CellConfiguration.customMaxElements()
    var time = BehaviorRelay(value: 0)
    var record = BehaviorRelay(value: 0)
    var selectCell = PublishRelay<Int>()
    var rightCellSelected = PublishRelay<Int>()
    var wrongCellSelected = PublishRelay<Int>()

    func start() {
        didUsePlayBack = false
        recoverRecord()
        setRoundTimer()
        setGameTimer()
        buttonSequence = []
        chooseCell()
    }

    func next() {
        numberOfHits.accept(numberOfHits.value+1)
        checkRecord()
        setRoundTimer()
        chooseCell()
    }

    func pause() {
        guard let roundTimer = roundTimer, let gameTimer = gameTimer else { return }
        roundTimer.invalidate()
        gameTimer.invalidate()
    }

    func resume() {
        setGameTimer()
        setRoundTimer()
        showSequence()
    }

    func playBack() {
        if !didUsePlayBack {
            suportSequence = buttonSequence
            setRoundTimer()
            showSequence()
        }
        didUsePlayBack = true
        setGameTimer()
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
            saveGame()
        }
    }

    func recoverRecord() {
        record.accept(Int(gameDataManager.fetchRecord()))
    }

    private func chooseCell() {
        guard let roundTimer = roundTimer else { return }
        let randomIndex = Int.random(in: 0...numberOfButtons-1)
        buttonSequence.append(randomIndex)
        userSequence = buttonSequence
        suportSequence = buttonSequence
        roundTimer.fire()
    }

    @objc private func showSequence() {
        guard let roundTimer = roundTimer else { return }
        if suportSequence.count > 0 {
            let nextButton = suportSequence.remove(at: 0)
            selectCell.accept(nextButton)
        } else { roundTimer.invalidate() }
    }

    @objc private func updateTime() {
        time.accept(time.value+1)
    }

    private func saveGame() {
        let round = RoundModel(elements: CellConfiguration.customMaxElements(), level: numberOfHits.value, time: time.value)
        gameDataManager.createRound(round)
    }

    private func setRoundTimer() {
        roundTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(showSequence), userInfo: nil, repeats: true)
    }

    private func setGameTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        gameTimer?.fire()
    }

    private func checkRecord() {
        if numberOfHits.value > record.value {
            record.accept(numberOfHits.value)
        }
    }
}
