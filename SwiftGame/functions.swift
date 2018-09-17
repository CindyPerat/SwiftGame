//
//  functions.swift
//  SwiftGame
//
//  Created by Cindy Perat on 14/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

//
func capitalizeFirstLetter(_ text: String) -> String {
    return text.prefix(1).uppercased() + text.dropFirst()
}

// Display teams and life points
func summary(game: Game) {
    print("\n-----------------------------")
    print("           RÉSUMÉ            ")
    print("-----------------------------")
    
    for player in game.players {
        print("\nÉQUIPE \(player.id) : \(player.name)")
        
        for character in player.team {
            print("  \(character.id). "
                + capitalizeFirstLetter(character.type.rawValue)
                + " - \(character.name)" + " - \(character.lifePoints) PDV")
        }
    }
}
