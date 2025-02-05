//
//  GameViewController.swift
//  Calorie Crusher
//
//  Created by Jeremiah Hicks on 1/27/25.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
        
    override func viewDidLoad() {
           super.viewDidLoad()
        
        
           if let view = self.view as! SKView? {
               // Load the SKScene from 'GameScene.sks'
               let scene = GameScene(size: CGSize(width: 1536, height: 2048))
               // Set the scale mode to scale to fit the window
               scene.scaleMode = .aspectFill
                   
               // Present the scene
               view.presentScene(scene)
               
               view.ignoresSiblingOrder = true
               
               view.showsFPS = false
               view.showsNodeCount = false
           }

       }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
