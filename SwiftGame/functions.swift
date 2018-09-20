//
//  functions.swift
//  SwiftGame
//
//  Created by Cindy Perat on 14/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

// Met la première lettre d'un mot en majuscule et le reste en minuscule
func capitalizeFirstLetter(_ text: String) -> String {
    return text.prefix(1).uppercased() + text.dropFirst()
}

// Marque une pause dans le déroulé du programme
func pressEnterToContinue() {
    print("\nAppuyez sur entrée pour continuer...", terminator: "")
    let _ = readLine()
}

func printInitialization(test: Bool) {
    print("\(Game.name) - NOUVELLE PARTIE")
    
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
        
        Game.players.append(player1)
        Game.players.append(player2)
    } else {
        // 2 ÉQUIPES
        for playerId in 1...Game.numberOfPlayers {
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
            
            Game.players.append(player)
        }
    }
    
    printSummary()
}

func printFight() {
    print("\n-----------------------------")
    print("     DÉBUT DE LA PARTIE      ")
    print("-----------------------------")
    
    while (!Game.isGameOver) {
        let actualPlayer = Game.getActualPlayer()
        
        print("\n-----------------------------")
        print("           MANCHE \(Game.round + 1)          ")
        print("-----------------------------")
        
        if Game.round == 0 {
            print("\nC'est \(actualPlayer.name) qui commence la partie !")
        } else {
            print("\nAu tour de \(actualPlayer.name) !")
        }
        
        print("\nAvec quel personnage de votre équipe voulez-vous jouer ?")
        let attackingCharacter = selectCharacter(from: actualPlayer)
        let defendingCharacter:Character
        
        if attackingCharacter.type == .mage { // Soin
            print("\nQuel personnage de votre équipe voulez-vous soigner ?")
            defendingCharacter = selectCharacter(from: actualPlayer, previouslySelected: attackingCharacter)
            
            // Soigner un personnage de son équipe
            defendingCharacter.isTreated(with: attackingCharacter.weapon)
            
            print("\n\(actualPlayer.name) a choisi de soigner son équipe...")
            print("\(defendingCharacter.name) récupére \(attackingCharacter.weapon.addingLifePoints) points de vie !")
        } else { // Attaque
            var weapon = attackingCharacter.weapon
            
            if let randomAttackWeapon = Game.randomAttackWeapon() {
                weapon = randomAttackWeapon
                print("\nSURPRISE ! \(attackingCharacter.name) est équipé d'une nouvelle arme \"\(weapon.name.rawValue)\" !")
            }
            
            print("\nContre qui souhaitez-vous attaquer ?")
            defendingCharacter = selectCharacter(from: Game.getOpposingPlayer(against: actualPlayer))
            
            // Retirer des PDV au personnage de l'équipe adverse
            defendingCharacter.isAttacked(with: weapon)
            
            print("\n\(actualPlayer.name) a choisi d'infliger des dégâts à l'équipe adverse...")
            print("\(attackingCharacter.name) contre \(defendingCharacter.name)...")
            print("\(defendingCharacter.name) perd \(weapon.removalLifePoints) points de vie !")
        }
        
        if !defendingCharacter.isAlive {
            print("\(defendingCharacter.name) vient de mourir...")
        }
        
        Game.round += 1
        
        pressEnterToContinue()
        printSummary()
        pressEnterToContinue()
    }
}

func printWinner() {
    print("\n-----------------------------")
    print("       FIN DE LA PARTIE      ")
    print("-----------------------------")
    
    print("\nBravo \(Game.getWinner().name), tu as gagné !")
}

func printStatistics() {
    print("\n-----------------------------")
    print("         STATISTIQUES        ")
    print("-----------------------------\n")
    
    for (name, value) in Game.getStatistics() {
        print("\(name) : \(value)")
    }
}

func selectCharacter(from player: Player, previouslySelected: Character? = nil) -> Character {
    var characters = player.team
    
    // Retire le personnage déjà sélectionné de la liste
    if let previousCharacter = previouslySelected, previousCharacter.type == .mage {
        characters = player.team.filter{ $0.type != .mage }
    }
    
    for character in characters {
        if character.isAlive {
            print("  \(character.id). "
                + capitalizeFirstLetter(character.name)
                + " (\(capitalizeFirstLetter(character.type.rawValue)))")
        }
    }
    
    while (true) {
        print("Numéro du personnage : ", terminator: "")
        
        if let selectedCharacter = readLine() { // Si la réponse n'est pas vide
            if let characterId = Int(selectedCharacter) { // Si un nombre a été entré
                let character = characters.filter{ $0.id == characterId } // Si ce nombre correspond à un personnage de l'équipe
                
                if !character.isEmpty {
                    return character[0]
                }
            }
        }
    }
}

// Affiche les équipes et les points de vie de chaque personnage
func printSummary() {
    print("\n-----------------------------")
    print("           RÉSUMÉ            ")
    print("-----------------------------")
    
    for player in Game.players {
        print("\nÉQUIPE \(player.id) : \(player.name)")
        
        for character in player.team {
            print("  \(character.id). "
                + capitalizeFirstLetter(character.name)
                + " (\(capitalizeFirstLetter(character.type.rawValue)))"
                + " : \(character.lifePoints) PDV")
        }
    }
}
