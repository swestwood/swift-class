//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Sophia Westwood on 1/7/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
