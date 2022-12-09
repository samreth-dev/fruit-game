//
//  GameModel.swift
//  Fruit-Game
//
//  Created by Samreth Kem on 12/4/22.
//

import Foundation

enum GameModel: String, CaseIterable {
    case ant
    case banana
    case mango
    case peach
    case strawberry
    case watermelon
    case monkey
    case orange
    case tiger
    case cherry
    case shared
}

extension GameModel {
    var easy: [GameModel] {
        get {
            Array(GameModel.allCases[0...5])
        }
    }
    
    var medium: [GameModel] {
        get {
            Array(GameModel.allCases[0...7])
        }
    }
    
    var hard: [GameModel] {
        get {
            Array(GameModel.allCases[0...9])
        }
    }
    
    var score: Int {
        get {
            switch self {
            case .ant:
                return -30
            case .banana:
                return 10
            case .cherry:
                return 45
            case .mango:
                return 15
            case .peach:
                return 25
            case .strawberry:
                return 20
            case .monkey:
                return -65
            case .tiger:
                return -100
            case .orange:
                return 35
            case .watermelon:
                return 30
            case .shared:
                return 0
            }
        }
    }
}
