//
//  Game.swift
//  SwiftGame
//
//  Created by Cindy Perat on 10/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

class Game {
    let name: String
    var round = 0
    let numberOfPlayers = 2
    var players = [Player]()
    var attackWeapons = [Sword(), Axe(), Rocket()]
    
    init(name: String) {
        self.name = name
    }
    
    // Définit le joueur attaquant
    func getActualPlayer() -> Player {
        return self.players[self.round % self.numberOfPlayers]
    }
    
    // Récupère le joueur adverse
    func getOpposingPlayer(against actualPlayer: Player) -> Player {
        return self.players.filter{ $0 !== actualPlayer }[0]
    }
    
    func randomAttackWeapon() -> Weapon? {
        if Int.random(in: 1...3) == 1 {
            return self.attackWeapons.randomElement()!
        }
        
        return nil
    }
    
    // Indique si la partie est terminée (quand il ne reste plus qu'un joueur en vie)
    var isGameOver: Bool {
        let playersAlive = self.players.filter{ $0.isAlive }.count // Nombre de joueurs en vie
        return playersAlive == 1 ? true : false
    }
    
    // Récupère le vainqueur du jeu
    func getWinner() -> Player {
        return self.players.filter{ $0.isAlive }[0]
    }
    
    func getStatistics() -> [String:Int] {
        return [
            "Nombre de tours": game.round + 1
        ]
    }
}
