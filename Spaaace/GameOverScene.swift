//
//  GameOverScene.swift
//  Spaaaaace
//
//  Created by Дюша on 07.11.2021.
//

import Foundation
import SpriteKit
import AVFoundation

class GameOverScene: SKScene {
    
    var ButtonAudioURL = NSURL(fileURLWithPath:Bundle.main.path(forResource: "loseSong", ofType: "mp3")!)
    var ButtonAudioURL1 = NSURL(fileURLWithPath:Bundle.main.path(forResource: "mainSong", ofType: "mp3")!)
    
    let restartLabel = SKLabelNode (fontNamed: "Impact")
    
    override func didMove(to view: SKView) {
        
        do {backingAudio = try AVAudioPlayer(contentsOf: ButtonAudioURL as URL, fileTypeHint: ".mp3")
            backingAudio.stop()
            backingAudio.play()
            backingAudio.numberOfLoops = -1
        } catch let error {
            print("error loading audio: Error: \(error)")
            
        }
        
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
        
        
        let gameOverLabel = SKLabelNode (fontNamed: "Impact")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 170
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint (x: self.size.width / 2, y: self.size.height * 0.7)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        let scoreLabel = SKLabelNode (fontNamed: "Impact")
        scoreLabel.text = "Score \(gameScore)"
        scoreLabel.fontSize = 125
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint (x: self.size.width / 2, y: self.size.height * 0.55)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        let defaults = UserDefaults()
        var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        if gameScore > highScoreNumber {
            highScoreNumber = gameScore
            defaults.set(highScoreNumber, forKey: "highScoreSaved")
        }
        
        let highScoreLabel = SKLabelNode(fontNamed: "Impact")
        highScoreLabel.text = "High score: \(highScoreNumber)"
        highScoreLabel.fontSize = 125
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.position = CGPoint (x: self.size.width / 2, y: self.size.height * 0.45)
        highScoreLabel.zPosition = 1
        self.addChild(highScoreLabel)
        
        
        restartLabel.text = "Restart"
        restartLabel.fontSize = 100
        restartLabel.fontColor = SKColor.white
        restartLabel.position = CGPoint (x: self.size.width / 2, y: self.size.height * 0.3)
        restartLabel.zPosition = 1
        self.addChild(restartLabel)
        
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            
            if restartLabel.contains(pointOfTouch) {
                do {backingAudio = try AVAudioPlayer(contentsOf: ButtonAudioURL1 as URL, fileTypeHint: ".mp3")
                    backingAudio.stop()
                    backingAudio.play()
                    backingAudio.numberOfLoops = -1
                } catch let error {
                    print("error loading audio: Error: \(error)")
                    
                }
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
