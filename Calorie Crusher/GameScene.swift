//
//  GameScene.swift
//  Calorie Crusher
//
//  Created by Jeremiah Hicks on 1/27/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let player = SKSpriteNode(imageNamed: "happyPlayer")
    
    
    let gameArea: CGRect
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0 / 6.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = 0
        addChild(background)
        
        let terrain = SKSpriteNode(imageNamed: "terrain")
        terrain.size = CGSize(width: 1000, height: 500)
        terrain.position = CGPoint(x: size.width/2, y: size.height/10)
        terrain.zPosition = 1
        addChild(terrain)
        
        let clouds = SKSpriteNode(imageNamed: "clouds")
        clouds.size = CGSize(width: 1350, height: 500)
        clouds.position = CGPoint(x: size.width / 2, y: size.height / 1.255)
        clouds.zPosition = 2
        addChild(clouds)
        
        let sun = SKSpriteNode(imageNamed: "sun")
        sun.size = CGSize(width: 315, height: 315)
        sun.position = CGPoint(x: size.width * 0.585, y: size.height/1.175)
        sun.zPosition = 1
        addChild(sun)
        
        let infoButton = SKSpriteNode(imageNamed: "infoButton")
        infoButton.size = CGSize(width: 100, height: 100)
        infoButton.position = CGPoint(x: size.width * 0.755, y: size.height/1.10)
        infoButton.zPosition = 3
        addChild(infoButton)
        
        let startButton = SKSpriteNode(imageNamed: "startButton")
        startButton.size = CGSize(width: 600, height: 120)
        startButton.position = CGPoint(x: size.width / 2, y: size.height / 2)
        startButton.zPosition = 3
        addChild(startButton)
        
        let leftArrow = SKSpriteNode(imageNamed: "leftArrow")
        leftArrow.size = CGSize(width: 300, height: 110)
        leftArrow.position = CGPoint(x: size.width / 3, y: size.height * 0.22)
        leftArrow.zPosition = 3
        addChild(leftArrow)
        
        let rightArrow = SKSpriteNode(imageNamed: "rightArrow")
        rightArrow.size = CGSize(width: 300, height: 110)
        rightArrow.position = CGPoint(x: size.width / 1.5, y: size.height * 0.22)
        rightArrow.zPosition = 3
        addChild(rightArrow)
        
        player.setScale(2.2)
        player.position = CGPoint(x: size.width/2, y: size.height * 0.23)
        player.zPosition = 3
//        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        self.addChild(player)
        
    }
    
}
