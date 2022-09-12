//
//  MainMenuScene.swift
//  Spaaaaace
//
//  Created by Дюша on 07.11.2021.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    var ButtonAudioURL = NSURL(fileURLWithPath:Bundle.main.path(forResource: "mainTrimpedSong", ofType: "mp3")!)
    
    let startGame = SKLabelNode(fontNamed: "Impact")
    
    override func didMove(to view: SKView) {
        
        for i in 0...1 {
            let background = SKSpriteNode(imageNamed: "background")
            background.size = self.size
            background.anchorPoint = CGPoint (x: 0.5, y: 0)
            background.position = CGPoint(x: self.size.width/2,
                                          y: self.size.height * CGFloat(i))
            background.name = "Backraund"
            background.zPosition = 0
            self.addChild(background)
            
        }
        
        let gameBy = SKLabelNode(fontNamed: "Impact")
        gameBy.text = "IGT Game Community"
        gameBy.fontSize = 50
        gameBy.fontColor = SKColor.white
        gameBy.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.78)
        gameBy.zPosition = 100
        self.addChild(gameBy)
        
        let gameName = SKLabelNode(fontNamed: "Impact")
        gameName.text = "Spaaaace"
        gameName.fontSize = 170
        gameName.fontColor = SKColor.white
        gameName.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.7)
        gameName.zPosition = 100
        self.addChild(gameName)
        
        startGame.text = "Start"
        startGame.fontSize = 150
        startGame.fontColor = SKColor.white
        startGame.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.4)
        startGame.zPosition = 100
        self.addChild(startGame)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            
            if startGame.contains(pointOfTouch) {
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 1)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
        
    }
    
    var lastUpdateTime: TimeInterval = 0
    var deltaFrameTime: TimeInterval = 0
    var amountToMoveToSecond: CGFloat = 100.0
    
    override func update(_ currentTime: TimeInterval) {
        
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        } else {
            deltaFrameTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
        }
        
        let amountToMoveBackground = amountToMoveToSecond * CGFloat(deltaFrameTime)
        
        self.enumerateChildNodes(withName: "Backraund") {
            background, stop in
            background.position.y -= amountToMoveBackground
            if background.position.y < -self.size.height {
                background.position.y += self.size.height * 2
            }
        }
    }
}
