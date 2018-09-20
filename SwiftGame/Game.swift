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
    
    /**
     Define if game is over (when only one team is alive)
     */
    var isGameOver: Bool {
        let playersAlive = self.players.filter{ $0.isAlive }.count // Nombre de joueurs en vie
        return playersAlive == 1 ? true : false
    }
    
    init(name: String) {
        self.name = name
    }
    
    /**
     Define attacking player
     - returns: Attacking player
     */
    func getActualPlayer() -> Player {
        return self.players[self.round % self.numberOfPlayers]
    }
    
    /**
     Define opposing player
     - parameter actualPlayer: Attacking player
     - returns: Opposing player
     */
    func getOpposingPlayer(against actualPlayer: Player) -> Player {
        return self.players.filter{ $0 !== actualPlayer }[0]
    }
    
    /**
     Generate random attack weapon
     - returns: Attack weapon
     */
    func randomAttackWeapon() -> Weapon? {
        if Int.random(in: 1...3) == 1 {
            return self.attackWeapons.randomElement()!
        }
        
        return nil
    }
    
    /**
     Define the winner
     - returns: Player who won the game
     */
    func getWinner() -> Player {
        return self.players.filter{ $0.isAlive }[0]
    }
    
    /**
     Define game statistics
     - returns: Array with name and value for each statistic
     */
    func getStatistics() -> [String:Int] {
        return [
            "Nombre de tours": game.round + 1
        ]
    }
}
