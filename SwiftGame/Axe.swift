//
//  Axe.swift
//  SwiftGame
//
//  Created by Cindy Perat on 19/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

class Axe: Weapon {
    init() {
        super.init(name: .axe, type: .attack, removalLifePoints: axeRemovalLifePoints, addingLifePoints: axeAddingLifePoints)
    }
}
