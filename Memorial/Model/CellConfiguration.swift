//
//  CellConfiguration.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/13/22.
//

import Foundation
import UIKit

struct CellConfiguration {

    static func size() -> Double {
        let height = UIScreen.main.bounds.height
        if  height <= 932 { return 61 }
        else if height < 1366 { return 125 }
        else { return 180 }
    }

    static func maxElements() -> Int {
        let height = UIScreen.main.bounds.height
        if height <= 667 { return 40 }
        else if height <= 932 { return 55 }
        else if height <= 1133 { return 35 }
        else if height <= 1194 { return 40 }
        else { return 45 }
    }
}
