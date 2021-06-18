//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//

import Foundation

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {

    func defineFirstAttackingPlayer(players: [Player]) -> Player? {
        func findMinCard(player:Player) -> Card? {
            var trumpCards:Set<Card> = []
            for card in player.hand ?? [] {
                if card.isTrump {
                    trumpCards.insert(card)
                }
            }
            return trumpCards.min { $0.value.rawValue < $1.value.rawValue }
        }
        var arrayMinCard = [Card?]()
        for player in players {
            arrayMinCard += [findMinCard(player: player)]
        }
        var min:Card? = nil
        for card in arrayMinCard {
            guard min != nil else { min = card; continue }
            if card != nil && card!.value.rawValue < min!.value.rawValue {
                min = card
            }
        }
        return min != nil ? players.first{ $0.hand!.contains(min!)} : nil
    }
    
}
