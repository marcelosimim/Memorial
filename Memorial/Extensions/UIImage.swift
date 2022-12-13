//
//  
//  UIImage.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/13/22.
//
//

import UIKit

extension UIImage {
    static func generateImage(_ name: String) -> UIImage {
        UIImage(named: name) ?? UIImage(systemName: "xmark.octagon.fill")!
    }

    static func generateSymbol(_ name: String) -> UIImage {
        UIImage(systemName: name) ?? UIImage(systemName: "xmark.octagon.fill")!
    }

    static var pause: UIImage { generateSymbol("pause.fill") }
}
