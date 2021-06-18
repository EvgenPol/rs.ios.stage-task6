//
//  Player.swift
//  DurakGame
//
//  Created by Дима Носко on 15.06.21.
//

import Foundation

protocol PlayerBaseCompatible {
    var hand: [Card]? { get set }
}

final class Player: PlayerBaseCompatible {
    var hand: [Card]?

    func checkIfCanTossWhenAttacking(card: Card) -> Bool {
        guard hand != nil && !hand!.isEmpty else {return false}
        return (hand!.contains(where: { $0.value == card.value }))
    }

    func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
        guard hand != nil && !hand!.isEmpty else {return false}
        for (cardOne,cardTwo) in table {
            return (hand!.contains(where: { $0.value == cardOne.value || $0.value == cardTwo.value }))
        }
        return false
    }
}
