//
//  GameScene.swift
//  iosGame
//
//  Created by IŞIL VARDARLI on 24.09.2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var anaKarekter: SKSpriteNode = SKSpriteNode()
    var sariYuvarlak:SKSpriteNode = SKSpriteNode()
    var kirmiziUcgen:SKSpriteNode = SKSpriteNode()
    var siyahKare:SKSpriteNode = SKSpriteNode()
    var skorLabel:SKLabelNode = SKLabelNode()
    
    var viewController : UIViewController?
    
    override func didMove(to view: SKView) {
        if let tempAnaKarekter = self.childNode(withName: "anakarekter") as? SKSpriteNode {
            anaKarekter = tempAnaKarekter
        }
        if let tempSariYuvarlak = self.childNode(withName: "sariyuvarlak") as? SKSpriteNode {
            sariYuvarlak = tempSariYuvarlak
        }
        if let tempKirmiziUcgen = self.childNode(withName: "kirmiziucgen") as? SKSpriteNode {
            kirmiziUcgen = tempKirmiziUcgen
        }
        if let tempSiyahKare = self.childNode(withName: "siyahkare") as? SKSpriteNode {
            siyahKare = tempSiyahKare
        }
        if let tempSkorLabel = self.childNode(withName: "skorlabel") as? SKLabelNode {
            skorLabel = tempSkorLabel
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.viewController?.performSegue(withIdentifier: "gameToSkor", sender: nil)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
