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
    
    init(id: Int, playerId: Int, name: String, type: CharacterType, lifePoints: Int) {
        self.id = id
        self.playerId = playerId
        self.name = name
        self.type = type
        self.lifePoints = lifePoints
    }
}
