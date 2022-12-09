//
//  GameEntryViewModel.swift
//  Fruit-Game
//
//  Created by Samreth Kem on 12/8/22.
//

import Foundation

class GameEntryViewModel {
    var games: [Game]? = nil
    let gameLevels = GameLevel.allCases
    
    func fetchGames() {
        games = DB.shared.fetch()
    }
}
