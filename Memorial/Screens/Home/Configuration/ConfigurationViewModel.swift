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
    func changeCellConfigurator(collection: Double, multiplier: Double)
}

final class ConfigurationViewModel: ConfigurationViewModelProtocol {
    func changeCellConfigurator(collection: Double, multiplier: Double) {
        let collectionHeight = collection - 20
        let cellHeight = 10+CellConfiguration.customSize()

        CellConfiguration.maxElements = Int(floor(collectionHeight/cellHeight))
        CellConfiguration.multiplier = multiplier    }
}
