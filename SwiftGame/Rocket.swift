//
//  Rocket.swift
//  SwiftGame
//
//  Created by Cindy Perat on 19/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

class Rocket: Weapon {
    init() {
        super.init(name: .rocket, type: .attack, removalLifePoints: rocketRemovalLifePoints, addingLifePoints: rocketAddingLifePoints)
    }
}
