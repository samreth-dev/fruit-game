//
//  GameManager.swift
//  Fruit-Game
//
//  Created by Samreth Kem on 12/4/22.
//

import Foundation

class GamePlayViewModel {
    @Published var score: Int = 0
    let gameLevel: GameLevel
    var models: [GameModel]
    var duration: CFTimeInterval = 0
    var speed: TimeInterval = 0
    private var game: Game?
    
    init(gameLevel: GameLevel, models: [GameModel], game: Game?) {
        self.gameLevel = gameLevel
        self.models = models
        self.game = game
        
        if let game = game {
            self.game = game
            self.score = Int(game.score)
        } else {
            self.game = DB.shared.newGame(level: gameLevel.rawValue)
        }
        setupGame()
    }
    
    func objectClicked(model: GameModel?) {
        if let model = model, let game = self.game {
            game.score += Int64(model.score)
            score = Int(game.score)
        }
    }
    
    func saveGame() {
        DB.shared.save()
    }
    
    private func setupGame() {
        switch gameLevel {
        case .easy:
            self.models = GameModel.shared.easy
            self.duration = 4.5
            self.speed = 0.45
        case .medium:
            self.models = GameModel.shared.medium
            self.duration = 3.5
            self.speed = 0.35
        case .hard:
            self.models = GameModel.shared.hard
            self.duration = 3
            self.speed = 0.25
        }
    }
}
