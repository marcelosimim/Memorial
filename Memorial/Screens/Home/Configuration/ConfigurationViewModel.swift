//
//  
//  ConfigurationViewModel.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/13/22.
//
//
import Foundation

protocol ConfigurationViewModelProtocol {
    func changeCellConfigurator(collection: CGRect, multiplier: Double)
    func resetRecord()
}

final class ConfigurationViewModel: ConfigurationViewModelProtocol {
    func changeCellConfigurator(collection: CGRect, multiplier: Double) {
        if !collection.height.isZero && !collection.width.isZero {
            let collectionHeight = collection.height - 20
            let cellHeight = 10+CellConfiguration.customSize()
            let maxRows = Int(floor(collectionHeight/cellHeight))

            let collectionWidht = collection.width
            let cellWidht = 10+CellConfiguration.customSize()
            let maxColumns = Int(floor(collectionWidht/cellWidht))

            CellConfiguration.maxElements = maxRows * maxColumns
            CellConfiguration.multiplier = multiplier
        }
    }

    func resetRecord() {
        GameDataManager.shared.deleteRecords()
    }
}
