//
//  GameScene.swift
//  ProtocolPlatformer
//
//  Created by Robert Desjardins on 2018-06-20.
//  Copyright © 2018 Robert Desjardins. All rights reserved.
//

import SpriteKit
import GameplayKit

let worldNode = SKNode()

// Background
var skyArr: [Sky] = []
var cloudArr: [Cloud] = []
var seaArr: [Sea] = []

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var lastUpdateTime : TimeInterval = 0
    
    
    override func sceneDidLoad() {
        addChild(worldNode)
        physicsWorld.contactDelegate = self
        self.lastUpdateTime = 0
        setUpBackground()
    }
    
    func setUpBackground() {
        setUpSky()
        setUpCloud()
        setUpSea()
    }
    
    func setUpSky() {
        var skyCount = 0
        let skyWidth = SkyAttributes().getSkyWidth()
        while CGFloat(skyArr.count) * skyWidth < GameData.shared.deviceWidth * 1.5 {
            let sky = Sky(imageNamed: "sky")
            sky.initSky()
            sky.position = CGPoint(x: skyCount * Int(skyWidth), y: 0)
            worldNode.addChild(sky)
            skyArr.append(sky)
            skyCount += 1
        }
    }
    
    func setUpCloud() {
        var cloudCount = 0
        let cloudWidth = CloudAttributes().getCloudWidth()
        while CGFloat(cloudArr.count) * cloudWidth < GameData.shared.deviceWidth * 2.0 {
            let cloud = Cloud(imageNamed: "clouds")
            cloud.initCloud()
            cloud.position = CGPoint(x: cloudCount * Int(cloudWidth), y: 0)
            worldNode.addChild(cloud)
            cloudArr.append(cloud)
            cloudCount += 1
        }
    }
    
    func setUpSea() {
        var seaCount = 0
        let seaWidth = SeaAttributes().getSeaWidth()
        while CGFloat(seaArr.count) * seaWidth < GameData.shared.deviceWidth * 1.7 {
            let sea = Sea(imageNamed: "sea")
            sea.initSea()
            sea.position = CGPoint(x: seaCount * Int(seaWidth), y: 0)
            worldNode.addChild(sea)
            seaArr.append(sea)
            seaCount += 1
        }
    }
    
    func updateBackgroud() {
        for element in skyArr {
            element.fly()
        }
        for element in cloudArr {
            element.fly()
        }
        for element in seaArr {
            element.fly()
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        print("touched down")
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
        
        updateBackgroud()
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        
        self.lastUpdateTime = currentTime
    }
}


func moveAlong(element: SKSpriteNode, array: [SKSpriteNode], speed: CGFloat) {
    element.position = CGPoint(x: element.position.x - speed, y: element.position.y)
    if element.position.x <= -element.size.width {
        element.position.x = array[ (array.index(of: element)! + array.count - 1) % array.count].position.x + element.size.width - 1
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
    var flySpeed: CGFloat { get }
    func fly()
}

protocol CanWalk: Entity {
    var walkSpeed: CGFloat { get }
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

struct SkyAttributes {
    func getSkyHeight() -> CGFloat {
        return GameData.shared.deviceHeight
    }
    func getSkyWidth() -> CGFloat {
        return getSkyHeight() * GameData.shared.skyHeightToWidthRatio
    }
}

struct CloudAttributes {
    func getCloudHeight() -> CGFloat {
        return GameData.shared.deviceHeight * (3/4)
    }
    func getCloudWidth() -> CGFloat {
        return getCloudHeight() * GameData.shared.cloudHeightToWidthRatio
    }
}

struct SeaAttributes {
    func getSeaHeight() -> CGFloat {
        return GameData.shared.deviceHeight * (7/24)
    }
    func getSeaWidth() -> CGFloat {
        return getSeaHeight() * GameData.shared.seaHeightToWidthRatio
    }
}

class Sky: SKSpriteNode, CanFly {
    func initSky() {
        anchorPoint = CGPoint(x: 0, y: 0)
        zPosition = -15
        size.width = SkyAttributes().getSkyWidth()
        size.height = SkyAttributes().getSkyHeight()
    }
    
    var flySpeed: CGFloat = 1.0
    
    func fly() {
        print("Sky trying to move")
        moveAlong(element: self, array: skyArr, speed: flySpeed)
    }
}

class Cloud: SKSpriteNode, CanFly {
    // TODO
    func initCloud() {
        anchorPoint = CGPoint(x: 0, y: 0)
        zPosition = -14
        
    }
    
    var flySpeed: CGFloat = 0.5
    
    func fly() {
        
    }
    
    
}

class Sea: SKSpriteNode, CanFly {
    // TODO
    func initSea() {
        
    }
    
    var flySpeed: CGFloat = 0.4
    
    func fly() {
        
    }
    
    
}

class Platform: SKSpriteNode, CanFly {
    
    var flySpeed: CGFloat = 0.0
    
    func fly() {
        // TODO
        print("Platform trying to move")
    }
    
    
}

struct Player: Entity, HasHealth, CanWalk, CanAttack {
    
    var id: String
    
    var health: Double
    
    var walkSpeed: CGFloat
    
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
    var flySpeed: CGFloat { return 10 }
    
    func attack() {
        // TODO
        print("Demon choosing an attack from \(attacks)")
    }
    
    func fly() {
        // TODO
        print("Demon Flying at a speed of \(flySpeed)")
    }
}
