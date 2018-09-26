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
     Return `true` if player is still alive with at least one character alive and if it is not a mage or `false`
     */
    var isAlive: Bool {
        let numberOfCharactersAlive = self.team.filter{ $0.isAlive }.count
        
        // If there is only a mage in the team, the player loses by forfeit because a mage can't attack
        if numberOfCharactersAlive == 1 {
            let characterAlive = self.team.filter{$0.isAlive}
            if characterAlive[0].type == .mage {
                return false
            }
        } else if numberOfCharactersAlive == 0 { // If there is no longer any character alive, the player loses the game
            return false
        }
        
        return true
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
