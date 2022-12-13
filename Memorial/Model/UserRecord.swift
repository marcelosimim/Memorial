//
//  UserRecord.swift
//  Memorial
//
//  Created by Marcelo Simim Santos on 12/13/22.
//

import Foundation

struct UserRecord {
    private let defaults = UserDefaults.standard
    private let key = "UserRecord"
    var currentRecord: Int { defaults.integer(forKey: key) }

    func setRecord(_ record: Int) {
        defaults.set(record, forKey: key)
    }
}
