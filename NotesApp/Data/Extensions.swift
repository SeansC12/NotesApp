//
//  Extensions.swift
//  NotesApp
//
//  Created by SEAN ULRIC BUGUINA CHUA stu on 12/11/21.
//

import Foundation

extension Dictionary {
    mutating func switchKey(fromKey: Key, toKey: Key) {
        if let entry = removeValue(forKey: fromKey) {
            self[toKey] = entry
        }
    }
}
