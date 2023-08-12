//
//  Dictionary+Extension.swift
//  HW17.1
//
//  Created by Sharipov Mehrob on 01.07.2023.
//

import Foundation


extension Dictionary {
    mutating func switchKey(fromKey: Key, toKey: Key) {
        if let entry = removeValue(forKey: fromKey) {
            self[toKey] = entry
        }
    }
}
