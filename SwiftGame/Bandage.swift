//
//  Bandage.swift
//  SwiftGame
//
//  Created by Cindy Perat on 19/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

class Bandage: Weapon {
    init() {
        super.init(type: .care, removalLifePoints: 0, addingLifePoints: 20)
    }
}
