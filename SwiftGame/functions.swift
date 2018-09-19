//
//  functions.swift
//  SwiftGame
//
//  Created by Cindy Perat on 14/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

// Met la première lettre d'un moment en majuscule et le reste en minuscule
func capitalizeFirstLetter(_ text: String) -> String {
    return text.prefix(1).uppercased() + text.dropFirst()
}

// Marque une pause dans le déroulé du programme
func pressEnterToContinue() {
    print("\nAppuyez sur entrée pour continuer...", terminator: "")
    let _ = readLine()
}

// Affiche les équipes et les points de vie de chaque personnage
func summary(game: Game) {
    print("\n-----------------------------")
    print("           RÉSUMÉ            ")
    print("-----------------------------")
    
    for player in game.players {
        print("\nÉQUIPE \(player.id) : \(player.name)")
        
        for character in player.team {
            print("  \(character.id). "
                + capitalizeFirstLetter(character.name)
                + " (\(capitalizeFirstLetter(character.type.rawValue)))"
                + " : \(character.lifePoints) PDV")
        }
    }
}

func selectCharacter(player: Player, previouslySelected: Character? = nil) -> Character {
    var characters = player.team
    
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
