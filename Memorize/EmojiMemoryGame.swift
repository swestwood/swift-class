//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created on 1/8/21.
//

import SwiftUI


// ViewModel responsible for presenting model data to the views in a
// way that's easy to consume for the views
class EmojiMemoryGame: ObservableObject {
    @Published private(set) var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["🦆", "🐓", "🦅", "🦉", "🦖", "🐥", "🦩", "🦤", "🦢", "🕊", "🦚",  "🦕"].shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) {pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // one liner
    //    MemoryGame<String>(numberOfPairsOfCards: 2) {_ in "🧐"}
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
}
