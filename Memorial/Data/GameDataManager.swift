//
//  GameDataManager.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/14/22.
//

import CoreData
import Foundation

class GameDataManager {
    static let shared = GameDataManager(modelName: "GameData")
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext { return persistentContainer.viewContext }

    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }

    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else { fatalError(error!.localizedDescription) }
        }
        completion?()
    }

    func save() {
        if viewContext.hasChanges {
            try? viewContext.save()
        }
    }
}

// MARK: - Helper function

extension GameDataManager {
    func createRound(_ model: RoundModel) {
        if roundAlreadyExist(model.elements) == nil {
            let round = Round(context: viewContext)
            round.level = Int16(model.level)
            round.elements = Int16(model.elements)
            round.time = Int32(model.time)
        } else {
            update(model)
        }

        save()
    }

    func fetchRounds() -> [Round] {
        let request: NSFetchRequest<Round> = Round.fetchRequest()
        return (try? viewContext.fetch(request)) ?? []
    }

    func deleteRecords() {
        let rounds = fetchRounds()
        for round in rounds {
            round.level = 0
        }
        save()
    }

    func deleteAll() {
        let rounds = fetchRounds()
        for round in rounds {
            viewContext.delete(round)
        }
        save()
    }

    func update(_ model: RoundModel) {
        let rounds = fetchRounds()
        for round in rounds {
            if round.elements == model.elements {
                if isAHighLevel(currentLevel: round.level, lastPlayed: model.level) {
                    round.level = Int16(model.level)
                    round.time = Int32(model.time)
                } else if isTheSameLevel(currentLevel: round.level, lastPlayed: model.level) && isALowerTime(currentTime: round.time, lastPlayed: model.time) {
                    round.time = Int32(model.time)
                }
            }
        }
    }

    private func roundAlreadyExist(_ elements: Int) -> Round? {
        let rounds = fetchRounds()
        for round in rounds {
            if round.elements == elements { return round }
        }
        return nil
    }

    private func isAHighLevel(currentLevel: Int16, lastPlayed: Int) -> Bool {
        lastPlayed > currentLevel
    }

    private func isTheSameLevel(currentLevel: Int16, lastPlayed: Int)-> Bool {
        lastPlayed == currentLevel
    }

    private func isALowerTime(currentTime: Int32, lastPlayed: Int) -> Bool {
        lastPlayed < currentTime
    }
}
