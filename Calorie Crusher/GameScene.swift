//
//  GameScene.swift
//  Calorie Crusher
//
//  Created by Jeremiah Hicks on 1/27/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let gameArea: CGRect
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0/7.2
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to: SKView) {
        // Background
        let background = SKSpriteNode(imageNamed: "staticBackground")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let player = SKSpriteNode(imageNamed: "happyCharacter")
        player.setScale(2)
        player.position = CGPoint(x: self.size.width/2, y: player.size.height * 1.78)
        player.zPosition = 2
        self.addChild(player)
        
        let scoreLabel = SKLabelNode(fontNamed: "SF Pro Rounded")
        scoreLabel.text = "Score"
        scoreLabel.fontSize = 80
        scoreLabel.fontColor = .black
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width * 0.22, y: self.size.height + scoreLabel.frame.size.height)
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        let scoreLabelBackground = SKSpriteNode
        
        let caloriesLabel = SKLabelNode(fontNamed: "SF Pro Rounded")
        caloriesLabel.text = "Calories"
        caloriesLabel.fontSize = 50
        caloriesLabel.fontColor = .white
        caloriesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        caloriesLabel.position = CGPoint(x: self.size.width * 0.78, y: self.size.height + caloriesLabel.frame.size.height)
        caloriesLabel.zPosition = 100
        self.addChild(caloriesLabel)
        
        let moveOnToScreenAction = SKAction.moveTo(y: self.size.height * 0.9, duration: 0.3)
        scoreLabel.run(moveOnToScreenAction)
        caloriesLabel.run(moveOnToScreenAction)
    }
}
