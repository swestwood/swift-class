//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created on 1/7/21.

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame

    let textPadding: CGFloat = 20
    
    var body: some View {
        VStack {
            HStack {
                Button(action: viewModel.newGame) {
                    Text("New Game")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, textPadding)
                .padding(.top, 20)
            }
            Grid(items: viewModel.cards) { card in
                CardView(card: card, color: viewModel.cardColor).onTapGesture {
                    viewModel.choose(card: card)
                }
                .padding(5)
            }
                .padding()
            HStack {
                Text("Theme: \(viewModel.themeName)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Score: \(viewModel.score)")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
                .padding(.horizontal, textPadding)
        }
    }
}

struct CardView: View {

    var card: MemoryGame<String>.Card
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(
                        LinearGradient(
                            gradient: .init(colors: [color, Color.red ]),
                              startPoint: .init(x: 0.5, y: 0),
                              endPoint: .init(x: 0.5, y: 0.6)
                            )
                    )
                }
                // otherwise will make an empty view
            }
        }.font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
