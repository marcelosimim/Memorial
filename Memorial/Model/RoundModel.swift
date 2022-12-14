//
//  
//  RoundModel.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/14/22.
//
//

import Foundation

struct RoundModel {
    let elements: Int
    let level: Int
    let time: Int

    func formattedTime() -> String {
        var seconds = time
        let hours = time/3600
        seconds %= 3600
        let minutes = seconds/60
        seconds %= 60

        return "\(formatTime(hours)):\(formatTime(minutes)):\(formatTime(seconds))"
    }

    private func formatTime(_ value: Int) -> String {
        if value < 10 { return "0\(value)"}
        return "\(value)"
    }
}

