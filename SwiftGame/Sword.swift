//
//  Sword.swift
//  SwiftGame
//
//  Created by Cindy Perat on 19/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

class Sword: Weapon {
    init() {
        super.init(name: .sword, type: .attack, removalLifePoints: 10, addingLifePoints: 0)
    }
}
