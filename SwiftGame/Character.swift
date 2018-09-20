//
//  Character.swift
//  SwiftGame
//
//  Created by Cindy Perat on 10/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

class Character {
    var id: Int
    var playerId: Int
    var name: String
    var type: CharacterType
    var lifePoints: Int
    var weapon: Weapon
    
    /**
     Return `true` if character is still alive or `false`
     */
    var isAlive: Bool {
        return lifePoints > 0 ? true : false
    }
    
    init(id: Int, playerId: Int, name: String, type: CharacterType, lifePoints: Int, weapon: Weapon) {
        self.id = id
        self.playerId = playerId
        self.name = name
        self.type = type
        self.lifePoints = lifePoints
        self.weapon = weapon
    }
    
    /**
     Run attack action
     - parameter weapon: Weapon used to attack
     */
    func isAttacked(with weapon: Weapon) {
        self.lifePoints -= weapon.removalLifePoints
    }
    
    /**
     Run care action
     - parameter weapon: Weapon used to treat character
     */
    func isTreated(with weapon: Weapon) {
        self.lifePoints += weapon.addingLifePoints
    }
}
