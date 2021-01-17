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
        let theme = emojiThemes.randomElement()!
        let emojis = theme.options.shuffled()
        let numPairs = theme.numberOfPairs ?? Int.random(in: 2...max(6, theme.options.count))
        return MemoryGame<String>(theme: theme, numberOfPairsOfCards: numPairs) {pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var themeName: String {
        model.theme.name
    }
    
    var cardColor: Color {
        model.theme.cardColor
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    
    // MARK: - Themes

    static let emojiThemes = [
        Theme(
            name: "Birds",
            options: ["🦆", "🐓", "🦅", "🦉", "🦖", "🐥", "🦩", "🦤", "🦢", "🕊", "🦚",  "🦕"],
            cardColor: Color.blue,
            numberOfPairs: 5
        ),
        Theme(
            name: "Flags",
            options: ["🏴‍☠️", "🇺🇸", "🇫🇷", "🏳️‍🌈", "🇩🇪"],
            cardColor: Color.purple,
            numberOfPairs: 4
        ),
        Theme(
            name: "Sports",
            options: ["🏄‍♀️", "⚽", "🏈", "🏀", "🏓", "⛷️"],
            cardColor: Color.yellow
        ),
        Theme(
            name: "Prizes",
            options: ["🏆", "🎖️", "🥇", "🥈", "🥉", "👏🏽", "🙇"],
            cardColor: Color.green
        ),
        Theme(
            name: "Foods I like",
            options: ["🍉", "🍒", "🫐", "🍓", "🥔", "🍧", "🥖", "🥨", "🥞", "🍕", "🍝", "🫕"],
            cardColor: Color.orange
        ),
        Theme(
            name: "Foods with bread",
            options: ["🌯", "🌮", "🥪", "🌭", "🍔", "🍕", "🥧"],
            cardColor: Color(hue: 177, saturation: 145, brightness: 93) // brown
        )
    ]
}
