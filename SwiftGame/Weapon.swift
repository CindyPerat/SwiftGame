//
//  Weapon.swift
//  SwiftGame
//
//  Created by Cindy Perat on 19/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

class Weapon {
    var type: WeaponType
    var removalLifePoints: Int
    var addingLifePoints: Int
    
    init(type: WeaponType, removalLifePoints: Int, addingLifePoints: Int) {
        self.type = type
        self.removalLifePoints = removalLifePoints
        self.addingLifePoints = addingLifePoints
    }
}
