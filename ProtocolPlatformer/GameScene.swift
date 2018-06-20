//
//  GameScene.swift
//  ProtocolPlatformer
//
//  Created by Robert Desjardins on 2018-06-20.
//  Copyright © 2018 Robert Desjardins. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        
        self.lastUpdateTime = currentTime
    }
}


protocol Entity {
    var name: String { get }
    var hasHealth: Bool { get }
    var canMove: Bool { get }
    var canAttack: Bool { get }
}

extension Entity {
    var hasHealth: Bool { return self is HasHealth}
    var canMove: Bool { return (self is CanFly) || (self is CanWalk)}
    var canAttack: Bool { return self is CanAttack}
}


protocol HasHealth {
    var health: Double { get }
}

protocol CanFly {
    var flySpeed: Double { get }
    func fly()
}

protocol CanWalk {
    var walkSpeed: Double { get }
    func walk()
}

protocol CanAttack {
    var attacks: [Attack] { get }
    func attack()
}

struct Attack {
    var name: String
    var attackDamage: Double
    var attackFrequency: TimeInterval
}

struct Player: Entity, HasHealth, CanWalk, CanAttack {
    
    var name: String
    
    var health: Double
    
    var walkSpeed: Double
    
    var attacks: [Attack]
    
    func attack() {
        <#code#>
    }
    
    func walk() {
        <#code#>
    }
}

let demonFire: Attack = Attack(name: "Fire", attackDamage: 10, attackFrequency: 5)
let demonCharge: Attack = Attack(name: "Charge", attackDamage: 5, attackFrequency: 10)
let demonAttacks: [Attack] = [demonFire, demonCharge]

struct Demon: Entity, HasHealth, CanFly, CanAttack {
    
    let name: String
    var health: Double
    var attacks: [Attack] { return demonAttacks }
    var flySpeed: Double { return 10 }
    
    func attack() {
        print("Demon choosing an attack from \(attacks)")
    }
    
    func fly() {
        print("Demon Flying at a speed of \(flySpeed)")
    }
}
