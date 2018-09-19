//
//  main.swift
//  SwiftGame
//
//  Created by Cindy Perat on 10/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

// INITIALISATION DU JEU -----------------------------------------------------------------------------------------------

var test = true // À passer à true pour le test de l'application
var game = Game(name: "SwiftGame")

print("\(game.name) - NOUVELLE PARTIE")

if test {
    print("\nInitialisation automatique...")
    
    // ÉQUIPE 1
    let player1 = Player(id: 1, name: "Cindy")
    player1.team.append(Fighter(id: 1, playerId: 1, name: "Toto"))
    player1.team.append(Mage(id: 2, playerId: 1, name: "Toutou"))
    player1.team.append(Colossus(id: 3, playerId: 1, name: "Tutu"))
    
    // ÉQUIPE 2
    let player2 = Player(id: 2, name: "Steve")
    player2.team.append(Dwarf(id: 1, playerId: 2, name: "Titi"))
    player2.team.append(Fighter(id: 2, playerId: 2, name: "Best Fighter Ever"))
    player2.team.append(Mage(id: 3, playerId: 2, name: "Best Mage Ever"))
    
    game.players.append(player1)
    game.players.append(player2)
} else {
    // 2 ÉQUIPES
    for playerId in 1...game.numberOfPlayers {
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
        for characterId in 1...player.numberOfCharacters {
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
            print("Numéro du personnage : ", terminator: "")
            
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

summary(game: game)

// DÉBUT DU COMBAT -----------------------------------------------------------------------------------------------------

print("\n-----------------------------")
print("     DÉBUT DE LA PARTIE      ")
print("-----------------------------")

while (!game.isGameOver) {
    let actualPlayer = game.getActualPlayer()
    
    print("\n-----------------------------")
    print("           MANCHE \(game.round + 1)          ")
    print("-----------------------------")
    
    if game.round == 0 {
        print("\nC'est \(capitalizeFirstLetter(actualPlayer.name)) qui commence la partie !")
    } else {
        print("\nAu tour de \(actualPlayer.name) !")
    }
    
    print("\nAvec quel personnage de votre équipe voulez-vous jouer ?")
    let attackingCharacter = selectCharacter(player: actualPlayer)
    print(attackingCharacter.name)
    
    if attackingCharacter.type == .mage {
        print("\nQuel personnage de votre équipe voulez-vous soigner ?")
        let defendingCharacter = selectCharacter(player: actualPlayer, previouslySelected: attackingCharacter)
        
        // Ajouter les points de vie
        
        print("\n\(actualPlayer.name) a choisi de soigner son équipe...")
        print("\(defendingCharacter.name) récupére X points de vie !")
    } else {
        print("\nContre qui souhaitez-vous attaquer ?")
        let defendingCharacter = selectCharacter(player: game.getOpposingPlayer(actualPlayer: actualPlayer))
        
        // Retirer les points de vie au personnage de l'équipe adverse
        
        print("\n\(actualPlayer.name) a choisi d'infliger des dégâts à l'équipe adverse...")
        print("\(attackingCharacter.name) contre \(defendingCharacter.name) !")
    }
    
    game.round += 1
    
    pressEnterToContinue()
    summary(game: game)
    pressEnterToContinue()
}

// VAINQUEUR -----------------------------------------------------------------------------------------------------------

//print("\n-----------------------------")
//print("          VAINQUEUR          ")
//print("-----------------------------")

//print("Bravo \(game.getWinner().name), tu as gagné !")


// STATISTIQUES DE FIN DE PARTIE ---------------------------------------------------------------------------------------

//print("\n-----------------------------")
//print("         STATISTIQUES        ")
//print("-----------------------------")

//print("\nNombre de tours : \(game.round + 1)")
//print("Arme la plus utilisée : ")
//print("Arme la moins utilisée : ")
//print("Nombre de soins : ")




