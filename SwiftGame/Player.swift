//
//  Player.swift
//  SwiftGame
//
//  Created by Cindy Perat on 10/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

class Player {
    var id: Int
    var name: String
    var team = [Character]()
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
