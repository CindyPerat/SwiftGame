//
//  Game.swift
//  SwiftGame
//
//  Created by Cindy Perat on 10/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

class Game {
    static let name = "SwiftGame"
    static var round = 0
    static let numberOfPlayers = 2
    static var players = [Player]()
    static var attackWeapons = [Sword(), Axe(), Rocket()]
    
    /**
     Define if game is over (when only one team is alive)
     */
    static var isGameOver: Bool {
        let playersAlive = self.players.filter{ $0.isAlive }.count // Nombre de joueurs en vie
        return playersAlive == 1 ? true : false
    }
    
    /**
     Define attacking player
     - returns: Attacking player
     */
    static func getActualPlayer() -> Player {
        return self.players[self.round % self.numberOfPlayers]
    }
    
    /**
     Define opposing player
     - parameter actualPlayer: Attacking player
     - returns: Opposing player
     */
    static func getOpposingPlayer(against actualPlayer: Player) -> Player {
        return self.players.filter{ $0 !== actualPlayer }[0]
    }
    
    /**
     Generate random attack weapon
     - returns: Attack weapon
     */
    static func randomAttackWeapon() -> Weapon? {
        if Int.random(in: 1...3) == 1 {
            return self.attackWeapons.randomElement()!
        }
        
        return nil
    }
    
    /**
     Define the winner
     - returns: Player who won the game
     */
    static func getWinner() -> Player {
        return self.players.filter{ $0.isAlive }[0]
    }
    
    /**
     Define game statistics
     - returns: Array with name and value for each statistic
     */
    static func getStatistics() -> [String:Int] {
        return [
            "Nombre de tours": Game.round + 1
        ]
    }
}
