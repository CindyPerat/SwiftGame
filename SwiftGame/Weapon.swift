//
//  Weapon.swift
//  SwiftGame
//
//  Created by Cindy Perat on 19/09/2018.
//  Copyright © 2018 Cindy Perat. All rights reserved.
//

class Weapon {
    var name: WeaponName
    var type: WeaponType
    var removalLifePoints: Int
    var addingLifePoints: Int
    
    init(name: WeaponName, type: WeaponType, removalLifePoints: Int, addingLifePoints: Int) {
        self.name = name
        self.type = type
        self.removalLifePoints = removalLifePoints
        self.addingLifePoints = addingLifePoints
    }
}
