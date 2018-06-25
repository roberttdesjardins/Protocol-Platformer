//
//  GameData.swift
//  ProtocolPlatformer
//
//  Created by Robert Desjardins on 2018-06-20.
//  Copyright © 2018 Robert Desjardins. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class GameData {
    static let shared = GameData()
    
    var deviceWidth = UIScreen.main.bounds.size.width
    var deviceHeight = UIScreen.main.bounds.size.height

    var skyHeightToWidthRatio: CGFloat = 0.3684
    var cloudHeightToWidthRatio: CGFloat = 2.3050
    var seaHeightToWidthRatio: CGFloat = 1.166
    
    let playerName = "player"
    let playerSize = CGSize(width: 40, height: 40) // TODO: Change based on screen size
    let playerTexture = SKTexture(imageNamed: "player_idle_frame_0_delay-0.13s")
    let playerHealth = 100
    let playerAttackDamage = 10
    let playerMoveSpeed = 10
    //let playerJumpHeight = 28
    let playerJumpHeight = 17
    let playerJumpHolding: CGFloat = 2.4
    
    let platformName = "platform"
    
    //private init() { }
}
