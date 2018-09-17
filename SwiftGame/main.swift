//
//  main.swift
//  SwiftGame
//
//  Created by Cindy Perat on 10/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

var test = true // À passer à true pour le test de l'application
var game = Game()

print("\(game.name) - NOUVELLE PARTIE")

if test {
    print("\nInitialisation automatique...")
    
    // ÉQUIPE 1
    let player1 = Player(id: 1, name: "Cindy")
    player1.team.append(Fighter(id: 1, playerId: 1, name: "Toto"))
    
    // ÉQUIPE 2
    let player2 = Player(id: 2, name: "Steve")
    player2.team.append(Dwarf(id: 1, playerId: 2, name: "Titi"))
    
    game.players.append(player1)
    game.players.append(player2)
} else {
    // 2 ÉQUIPES
    for playerId in 1...2 {
        print("\n-----------------------------")
        print("           ÉQUIPE \(playerId)       ")
        print("-----------------------------")
        print("Nom du joueur : ", terminator: "")
        
        var playerName = ""
        if let choice = readLine() {
            playerName = choice
        }
        
        let player = Player(id: playerId, name: playerName)
        
        // 3 PERSONNAGES PAR ÉQUIPE
        for characterId in 1...3 {
            print("\n-----------------------------")
            print("         PERSONNAGE \(characterId)     ")
            print("-----------------------------")
            print("Nom : ", terminator: "")
            
            var characterName = ""
            if let choice = readLine() {
                characterName = choice
            }
            
            print("\nType :")
            print("  1. " + capitalizeFirstLetter(CharacterType.fighter.rawValue))
            print("  2. " + capitalizeFirstLetter(CharacterType.mage.rawValue))
            print("  3. " + capitalizeFirstLetter(CharacterType.colossus.rawValue))
            print("  4. " + capitalizeFirstLetter(CharacterType.dwarf.rawValue))
            print("Votre choix : ", terminator: "")
            
            if let choice = readLine() {
                switch choice {
                case "1":
                    player.team.append(Fighter(id: characterId, playerId: playerId, name: characterName))
                case "2":
                    player.team.append(Mage(id: characterId, playerId: playerId, name: characterName))
                case "3":
                    player.team.append(Colossus(id: characterId, playerId: playerId, name: characterName))
                case "4":
                    player.team.append(Dwarf(id: characterId, playerId: playerId, name: characterName))
                default:
                    print("Vous devez choisir un type pour ce personnage.")
                }
            }
        }
        
        game.players.append(player)
    }
}

/*print("\n-----------------------------")
print("           RÉSUMÉ            ")
print("-----------------------------")

for (playerIndex,player) in game.players.enumerated() {
    print("\nÉQUIPE \(playerIndex + 1) : \(player.name)")
    
    for (characterIndex,character) in player.team.enumerated() {
        print("  \(characterIndex + 1). " + capitalizeFirstLetter(character.type.rawValue) + " - \(character.name)")
    }
}*/

summary(game: game)

/*print("\n-----------------------------")
print("     DÉBUT DE LA PARTIE      ")
print("-----------------------------")

print("C'est Cindy qui ouvre le bal !")
print("Cindy, quel personnage de ton équipe choisis-tu ?")
print("Contre qui souhaites-tu attaquer ?")

print("Cindy a choisi d'infliger des dégâts à l'équipe adverse")
print("Cindy a choisi de soigner son équipe")*/

// Afficher résumé




