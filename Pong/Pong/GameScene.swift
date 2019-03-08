//
//  GameScene.swift
//  Pong
//
//  Created by flavio mattos on 24/02/19.
//  Copyright © 2019 flavio mattos. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var man = SKSpriteNode()
    var enemy = SKSpriteNode()
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        startGame()
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        man = self.childNode(withName: "man") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
       
       ball.physicsBody?.applyImpulse(CGVector(dx: 100 ,dy: 100))

        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
    }
    
    func startGame() {
        score = [0,0]
    }
    
   // func leafdesappear(){
        
   // }
    
    func addScore(playerWhoWon : SKSpriteNode){
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == man {
            score[0] += 1
             ball.physicsBody?.applyImpulse(CGVector(dx: 100 ,dy: 100))
        } else if playerWhoWon == enemy {
            score[1] += 1
             ball.physicsBody?.applyImpulse(CGVector(dx: -100 ,dy: -100))
        }
        print(score)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            man.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            man.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
         enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
        if ball.position.y <= man.position.y - 70 {
             addScore(playerWhoWon : enemy)
        }
            else if ball.position.y >= enemy.position.y + 70 {
             addScore(playerWhoWon : man)
            }
    }
}

