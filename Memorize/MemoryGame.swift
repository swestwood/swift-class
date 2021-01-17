//
//  MemoryGame.swift
//  Memorize
//
//  Created on 1/8/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var score: Int
    var theme: Theme<CardContent>
    
    var indexOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                if cards[index].isFaceUp {
                    // if this faceup card was already seen, minus one point
                    if cards[index].isSeen && !cards[index].isMatched {
                        score -= 1
                    }
                    // cards become seen when they transition from face up to face down
                    cards[index].isSeen = true
                }
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card),
                !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOnlyFaceUpCard {
                // There's already a card face up, so see if we have a match
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                // This handles resetting all the other cards to facedown
                indexOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(theme: Theme<CardContent>, numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        score = 0
        self.theme = theme
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(isMatched: false, content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        // This one is namespaced as MemoryGame.Card
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isSeen: Bool = false
        var content: CardContent
        var id: Int
    }
}
