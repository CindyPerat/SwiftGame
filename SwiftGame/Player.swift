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
    
    var isAlive: Bool {
        let charactersAliveCount = self.team.filter{ $0.isAlive }.count // Nombre de personnages en vie
        return charactersAliveCount == 0 ? false : true // Si aucun en vie, alors le joueur a perdu
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    // À SUPPRIMER
    // Récupère un personnage à partir de son ID
    /*func findCharacter(characterId: Int) -> Character? {
        for character in self.team {
            if character.id == characterId {
                return character
            }
        }
        
        return nil
    }*/
}
