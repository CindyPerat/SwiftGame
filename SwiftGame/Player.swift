//
//  Player.swift
//  SwiftGame
//
//  Created by Cindy Perat on 10/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

class Player {
    var id: Int
    var name: String
    var numberOfCharacters = 3
    var team = [Character]()
    
    /**
     Return `true` if player is still alive with at least one character alive or `false`
     */
    var isAlive: Bool {
        let charactersAliveCount = self.team.filter{ $0.isAlive }.count // Nombre de personnages en vie
        return charactersAliveCount == 0 ? false : true // Si aucun en vie, alors le joueur a perdu
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
