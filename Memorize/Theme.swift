//
//  EmojiTheme.swift
//  Memorize
//
//  Created 1/15/21.
//

import SwiftUI

struct Theme<T> {
    var name: String
    var options: Array<T>
    var cardColor: Color
    var numberOfPairs: Int?
}
