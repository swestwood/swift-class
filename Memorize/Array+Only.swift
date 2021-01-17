//
//  Array+Only.swift
//  Memorize
//
//  Created on 1/11/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
