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
    static func uid() -> String
    var hasHealth: Bool { get }
    var canMove: Bool { get }
    var canAttack: Bool { get }
}

extension SKSpriteNode: Entity { }

extension Entity {
    static func uid() -> String {
        return UUID().uuidString
    }
    var hasHealth: Bool { return self is HasHealth}
    var canMove: Bool { return (self is CanFly) || (self is CanWalk)}
    var canAttack: Bool { return self is CanAttack}
}


protocol HasHealth: Entity {
    var health: Double { get }
}


protocol CanFly: Entity {
    var flySpeed: Double { get }
    func fly()
}

protocol CanWalk: Entity {
    var walkSpeed: Double { get }
    func walk()
}

protocol CanAttack: Entity {
    var attacks: [Attack] { get }
    func attack()
}

struct Attack {
    var name: String
    var attackDamage: Double
    var attackFrequency: TimeInterval
}

class sky: SKSpriteNode, CanFly {
    private var skyHeight: CGFloat = 0.0
    private var skyWidth: CGFloat = 0.0
    func initSky() {
        skyHeight = GameData.shared.deviceHeight
        skyWidth = skyHeight * 0.3684
    }
    
    var flySpeed: Double = 0.0
    
    
    
    func fly() {
        print("Sky trying to move")
    }
    
    
}

class Platform: SKSpriteNode, CanFly {
    
    var flySpeed: Double = 0.0
    
    func fly() {
        // TODO
        print("Platform trying to move")
    }
    
    
}

struct Player: Entity, HasHealth, CanWalk, CanAttack {
    
    var id: String
    
    var health: Double
    
    var walkSpeed: Double
    
    var attacks: [Attack]
    
    func attack() {
        // TODO
        print("Player trying to attack")
    }
    
    func walk() {
        // TODO
        print("Player trying to walk")
    }
}

let demonFire: Attack = Attack(name: "Fire", attackDamage: 10, attackFrequency: 5)
let demonCharge: Attack = Attack(name: "Charge", attackDamage: 5, attackFrequency: 10)
let demonAttacks: [Attack] = [demonFire, demonCharge]

struct Demon: Entity, HasHealth, CanFly, CanAttack {
    
    let id: String
    var health: Double
    var attacks: [Attack] { return demonAttacks }
    var flySpeed: Double { return 10 }
    
    func attack() {
        // TODO
        print("Demon choosing an attack from \(attacks)")
    }
    
    func fly() {
        // TODO
        print("Demon Flying at a speed of \(flySpeed)")
    }
}
