//
//  functions.swift
//  SwiftGame
//
//  Created by Cindy Perat on 14/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

import Foundation

/**
 Uppercase first letter of text
 - parameter text: Text to edit
 - returns: Text edited with first letter capitalized
 */
func capitalizeFirstLetter(_ text: String) -> String {
    return text.prefix(1).uppercased() + text.dropFirst()
}

/**
 Pause application and wait for user action to continue
 */
func pressEnterToContinue() {
    print("\nAppuyez sur entrée pour continuer...", terminator: "")
    let _ = readLine()
}

/**
 Display game initialization with creation of teams and characters
 - parameter test: `true` to test application, otherwise `false`
 */
func printInitialization(test: Bool) {
    print("\(Game.name) - NOUVELLE PARTIE")
    
    if test {
        print("\nInitialisation automatique...")
        
        // ÉQUIPE 1
        let player1 = Player(id: 1, name: "Cindy")
        player1.team.append(Fighter(id: 1, playerId: 1, name: "Toto"))
        player1.team.append(Dwarf(id: 2, playerId: 1, name: "Tutu"))
        player1.team.append(Mage(id: 3, playerId: 1, name: "Toutou"))
        
        // ÉQUIPE 2
        let player2 = Player(id: 2, name: "Steve")
        player2.team.append(Fighter(id: 1, playerId: 2, name: "Best Fighter Ever"))
        player2.team.append(Dwarf(id: 2, playerId: 2, name: "Titi"))
        player2.team.append(Mage(id: 3, playerId: 2, name: "Best Mage Ever"))
        
        Game.players.append(player1)
        Game.players.append(player2)
    } else {
        // 2 ÉQUIPES
        for playerId in 1...Game.numberOfPlayers {
            print("\n-----------------------------")
            print("           ÉQUIPE \(playerId)       ")
            print("-----------------------------")
            
            var playerName = ""
            
            repeat {
                print("Nom du joueur : ", terminator: "")
                
                if let choice = readLine() {
                    playerName = choice
                }
            } while playerName.isEmpty
            
            let player = Player(id: playerId, name: playerName)
            Game.players.append(player)
            
            // 3 PERSONNAGES PAR ÉQUIPE
            for characterId in 1...player.numberOfCharacters {
                print("\n-----------------------------")
                print("         PERSONNAGE \(characterId)     ")
                print("-----------------------------")
                
                var characterName = ""
                
                repeat {
                    print("Nom : ", terminator: "")
                    
                    if let choice = readLine() {
                        characterName = choice
                    }
                } while !Game.isCharacterNameUnique(characterName) || characterName.isEmpty
                
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
        }
    }
    
    printSummary()
    pressEnterToContinue()
}

/**
 Display fight
 */
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
        
        if attackingCharacter.type == .mage { // Care
            print("\nQuel personnage de votre équipe voulez-vous soigner ?")
            defendingCharacter = selectCharacter(from: actualPlayer, previouslySelected: attackingCharacter)
            
            defendingCharacter.isTreated(with: attackingCharacter.weapon)
            
            print("\n\(actualPlayer.name) a choisi de soigner son équipe...")
            print("\(defendingCharacter.name) récupére \(attackingCharacter.weapon.addingLifePoints) points de vie !")
            
            Game.numberOfUses[.bandage]! += 1
            Game.numberOfCare += 1
        } else { // Attack
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
            
            Game.numberOfUses[weapon.name]! += 1
            Game.numberOfAttacks += 1
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

/**
 Display winner
 */
func printWinner() {
    print("\n-----------------------------")
    print("       FIN DE LA PARTIE      ")
    print("-----------------------------")
    
    print("\nBravo \(Game.getWinner().name), tu as gagné !")
}

/**
 Display statistics
 */
func printStatistics() {
    print("\n-----------------------------")
    print("         STATISTIQUES        ")
    print("-----------------------------\n")
    
    // Number of rounds
    print("  - Nombre de tours : \(Game.round)")
    
    // Number of attacks
    print("  - Nombre d'attaques : \(Game.numberOfAttacks)")
    
    // Number of care
    print("  - Nombre de soins : \(Game.numberOfCare)")
    
    // Most used weapon(s)
    let maxNumberOfUses = Game.numberOfUses.values.max()!
    let mostUsedWeapons = Game.numberOfUses.filter{ $0.value == maxNumberOfUses }
    
    if mostUsedWeapons.count > 1 {
        print("  - Armes les plus utilisées avec \(maxNumberOfUses) coups chacune : ")
        
        for (weapon, _) in mostUsedWeapons {
            print("      - \(capitalizeFirstLetter(weapon.rawValue))")
        }
    } else {
        print("  - Arme la plus utilisée avec \(maxNumberOfUses) coups : \(mostUsedWeapons.first!.key.rawValue)")
    }
    
    // Least used weapon(s)
    let minNumberOfUses = Game.numberOfUses.values.min()!
    let leastUsedWeapons = Game.numberOfUses.filter{ $0.value == minNumberOfUses }
    
    if leastUsedWeapons.count > 1 {
        print("  - Armes les moins utilisées avec \(minNumberOfUses) coups chacune : ")
        
        for (weapon, _) in leastUsedWeapons {
            print("      - \(capitalizeFirstLetter(weapon.rawValue))")
        }
    } else {
        print("  - Arme la moins utilisée avec \(minNumberOfUses) coups : \(leastUsedWeapons.first!.key.rawValue)")
    }
}

/**
 Handle and display selection of character
 - parameter player: Selected player
 - parameter previouslySelected: Character previously selected (used when mage has been selected as attacking character)
 - returns: Text edited with first letter capitalized
 */
func selectCharacter(from player: Player, previouslySelected: Character? = nil) -> Character {
    var characters = player.team
    
    // Remove mage from the list if he's been previously selected as attacking character
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
        
        if let selectedCharacter = readLine() { // If response isn't empty
            if let characterId = Int(selectedCharacter) { // If a number has been entered
                let character = characters.filter{ $0.id == characterId } // If this number matches vith a character
                
                if !character.isEmpty {
                    return character[0]
                }
            }
        }
    }
}

/**
 Display life points for each character
 */
/*func printSummary() {
    print("\n-----------------------------")
    print("           RÉSUMÉ            ")
    print("-----------------------------")
    
    for player in Game.players {
        print("\nÉQUIPE \(player.id) : \(player.name)")
        
        for character in player.team {
            if character.isAlive {
                print("  \(character.id). "
                    + capitalizeFirstLetter(character.name)
                    + " (\(capitalizeFirstLetter(character.type.rawValue)))"
                    + " : \(character.lifePoints) PDV")
            }
        }
    }
}*/

func printSummary() {
    let line = "".padding(toLength: 90, withPad: "-", startingAt: 0)
    
    print("\n" + line)
    print(" RÉSUMÉ")
    print(line)
    
    for player in Game.players {
        print("\n ÉQUIPE \(player.id) : \(player.name)".padding(toLength: 90, withPad: " ", startingAt: 0))
        print(line)
        print(" ", terminator: "")
        
        let headers = ["Nom du personnage", "Type", "PDV"]
        for header in headers {
            print(header.padding(toLength: 30, withPad: " ", startingAt: 0), terminator: "")
        }
        
        print("\n" + line)
        
        for character in player.team {
            if character.isAlive {
                let name = capitalizeFirstLetter(character.name)
                let type = capitalizeFirstLetter(character.type.rawValue)
                let lifePoints = String(character.lifePoints)
                
                print(" " + name.padding(toLength: 30, withPad: " ", startingAt: 0)
                    + type.padding(toLength: 30, withPad: " ", startingAt: 0)
                    + lifePoints.padding(toLength: 30, withPad: " ", startingAt: 0))
            }
        }
        
        print(line)
    }
}
