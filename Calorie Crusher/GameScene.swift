//
//  GameScene.swift
//  Calorie Crusher
//
//  Created by Jeremiah Hicks on 1/27/25.
//



import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    

    var isTouchEnabled: Bool = false
    var isInfoScreenVisible = false
    
    let player1 = SKSpriteNode(imageNamed: "happyPlayer")
    let player2 = SKSpriteNode(imageNamed: "madPlayer")
    var players: [SKSpriteNode] = []
    var currentPlayyerIndex = 0 // tracks which player is active
    
    var infoScreen: SKSpriteNode!
    var closeButton: SKSpriteNode!
    
    var infoButton: SKSpriteNode!
    var startButton: SKSpriteNode!
    var leftArrow: SKSpriteNode!
    var rightArrow: SKSpriteNode!
    
    var interactiveNodes: [SKSpriteNode] = []
    
    struct PhysicsCategories {
        static let None: UInt32 = 0
        static let Player: UInt32 = 0b1 // 1 in Binary
        static let Bullet: UInt32 = 0b10 // 2 in Binary
        static let Enemy: UInt32 = 0b100 // 4 in Binary
    }
    
    enum gameState {
        case preGame
        case inGame
        case afterGame
    }
    
    var currentGameState = gameState.preGame
    
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
        
        // Background
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = 0
        addChild(background)
        
        // Terrain
        let terrain = SKSpriteNode(imageNamed: "terrain")
        terrain.size = CGSize(width: 1000, height: 500)
        terrain.position = CGPoint(x: size.width/2, y: size.height/10)
        terrain.zPosition = 1
        addChild(terrain)
        
        // Clouds
        let clouds = SKSpriteNode(imageNamed: "clouds")
        clouds.size = CGSize(width: 1350, height: 500)
        clouds.position = CGPoint(x: size.width / 2, y: size.height / 1.255)
        clouds.zPosition = 2
        addChild(clouds)
        
        // Sun
        let sun = SKSpriteNode(imageNamed: "sun")
        sun.size = CGSize(width: 315, height: 315)
        sun.position = CGPoint(x: size.width * 0.585, y: size.height/1.175)
        sun.zPosition = 1
        addChild(sun)
        
        // Create Info Screen
        infoScreen = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.75), size: CGSize(width: 800, height: 1350))
        infoScreen.position = CGPoint(x: size.width / 2, y: size.height / 2)
        infoScreen.zPosition = 10
        infoScreen.alpha = 0  // Initially hidden
        infoScreen.name = "infoScreen"
        addChild(infoScreen)

//        // Create Close Button
//        closeButton = SKSpriteNode(imageNamed: "closeButton") // Use an image or color
//        closeButton.size = CGSize(width: 100, height: 100)
//        closeButton.position = CGPoint(x: size.width * 0.85, y: size.height * 0.85)
//        closeButton.zPosition = 11
//        closeButton.name = "closeButton"
//        infoScreen.addChild(closeButton)

        // Optionally, add text inside the info screen
        let infoLabel = SKLabelNode(text: "This is the game info!")
        infoLabel.fontSize = 40
        infoLabel.fontColor = .white
        infoLabel.position = CGPoint(x: 0, y: 0) // Center of the screen
        infoLabel.zPosition = 11
        infoScreen.addChild(infoLabel)
        
        // Create Buttons & Interactive Nodes
        startButton = createInteractiveNode(imageName: "startButton", size: CGSize(width: 600, height: 120), position: CGPoint(x: size.width / 2, y: 1000), name: "startButton")
        infoButton = createInteractiveNode(imageName: "infoButton", size: CGSize(width: 100, height: 100), position: CGPoint(x: size.width * 0.755, y: size.height / 1.10), name: "infoButton")
        leftArrow = createInteractiveNode(imageName: "leftArrow", size: CGSize(width: 300, height: 110), position: CGPoint(x: size.width / 3, y: size.height * 0.22), name: "leftArrow")
        rightArrow = createInteractiveNode(imageName: "rightArrow", size: CGSize(width: 300, height: 110), position: CGPoint(x: size.width / 1.5, y: size.height * 0.22), name: "rightArrow")
        
        // Player
        player1.setScale(2.2)
        player1.position = CGPoint(x: size.width / 2, y: size.height * 0.23)
        player1.zPosition = 3
        addChild(player1)
        
        // Player 2
        player2.setScale(2.2)
        player2.position = CGPoint(x: size.width / 2, y: size.height * 0.23)
        player2.zPosition = 3
        addChild(player2)
        
        players = [player1, player2]
        
    }
    
    // Function to Create Interactive Nodes
    func createInteractiveNode(imageName: String, size: CGSize, position: CGPoint, name: String) -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: imageName)
        node.size = size
        node.position = position
        node.zPosition = 3
        node.name = name
        addChild(node)
        interactiveNodes.append(node) // Store it in the array
        return node
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = self.atPoint(location)
        
        if let nodeName = touchedNode.name {
            switch nodeName {
            case "startButton":
                print("Start button clicked!")
                startGame()
                
            case "infoButton":
                print("Info button clicked!")
                infoButtonClick()
                showInfo()
                
            case "leftArrow":
                print("Left arrow clicked!")
               switchPlayer(-1)
                
            case "rightArrow":
                print("Right arrow clicked!")
                switchPlayer(1)
                
//            case "closeButton":
//                print("Closing info screen!")
//                closeInfoScreen()
                
            default:
                // If the info screen is open and user clicks outside, close it
                            if isInfoScreenVisible {
                                hideInfoScreen()
                            }
                        }
                    } else {
                        // If the user touches an unnamed node (e.g., background), hide the info screen
                        if isInfoScreenVisible {
                            hideInfoScreen()
                
            }
        }
    }
    
    // Switch player function
    func switchPlayer(_ direction: Int) {
        let currentPlayer = players[currentPlayyerIndex]
        currentPlayyerIndex += direction
        
        if currentPlayyerIndex < 0 {
            currentPlayyerIndex = players.count - 1 // Loop baack to last player
        } else if currentPlayyerIndex >= players.count {
            currentPlayyerIndex = 0 // Loop back to first player
        }
        let newPlayer = players[currentPlayyerIndex]
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.3)
           let scaleDown = SKAction.scale(to: 1.8, duration: 0.3) // Slightly shrink
           let fadeIn = SKAction.fadeIn(withDuration: 0.3)
           let scaleUp = SKAction.scale(to: 2.2, duration: 0.3) // Return to normal size

           let disappear = SKAction.group([fadeOut, scaleDown]) // Shrink & fade out
           let appear = SKAction.group([fadeIn, scaleUp]) // Grow & fade in

           currentPlayer.run(disappear) // Hide old player
           newPlayer.run(appear) // Show new player
        
        
        print("Switched to player \(currentPlayyerIndex + 1)")
    }
    
    
    // Actions for Buttons
    func startGame() {
        currentGameState = .inGame
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        let deleteAction = SKAction.removeFromParent()
        startButton.run(SKAction.sequence([fadeOutAction, deleteAction]))
    }
    
    func infoButtonClick() {
        let scaleDown = SKAction.scale(to: 1.8, duration: 0.3) // Slightly shrink
        let scaleUp = SKAction.scale(to: 2.2, duration: 0.3) // Return to normal size
        infoButton.run(SKAction.sequence([scaleDown, scaleUp, scaleDown]))
    }
    
    func showInfo() {
        if isInfoScreenVisible {
               // If the info screen is already visible, hide it
               hideInfoScreen()
           } else {
               // Show the info screen
               let fadeInAction = SKAction.fadeIn(withDuration: 0.3)
               infoScreen.run(fadeInAction)
               isInfoScreenVisible = true
           }
    }
    
    func hideInfoScreen() {
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.3)
        infoScreen.run(fadeOutAction)
        isInfoScreenVisible = false
    }
    
//    func closeInfoScreen() {
//        let fadeOutAction = SKAction.fadeOut(withDuration: 0.3)
//        infoScreen.run(fadeOutAction) // Hide the info screen smoothly
//    }
    
    func moveLeft() {
        players[currentPlayyerIndex].position.x -= 50
    }
    
    func moveRight() {
        players[currentPlayyerIndex].position.x += 50

    }
}
