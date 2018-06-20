//
//  GameViewController.swift
//  ProtocolPlatformer
//
//  Created by Robert Desjardins on 2018-06-20.
//  Copyright © 2018 Robert Desjardins. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        
        if let scene = GameScene(size: view.bounds.size) as GameScene? {
            scene.scaleMode = .aspectFill
            if let skView = view as? SKView {
                skView.presentScene(scene)
                skView.ignoresSiblingOrder = true
                skView.showsFPS = true
                skView.showsNodeCount = true
            }
        }
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
