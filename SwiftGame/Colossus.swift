//
//  Colossus.swift
//  SwiftGame
//
//  Created by Cindy Perat on 10/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

class Colossus: Character {
    init(id: Int, playerId: Int, name: String) {
        super.init(id: id, playerId: playerId, name: name, type: .colossus, lifePoints: 200, weapon: Rocket())
    }
}
