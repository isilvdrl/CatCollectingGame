//
//  GameScene.swift
//  iosGame
//
//  Created by IŞIL VARDARLI on 24.09.2024.
//
import UIKit
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var anaKarakter: SKSpriteNode = SKSpriteNode()
    var sariDaire:SKSpriteNode = SKSpriteNode()
    var kirmiziUcgen:SKSpriteNode = SKSpriteNode()
    var siyahKare:SKSpriteNode = SKSpriteNode()
    var skorLabel:SKLabelNode = SKLabelNode()
    //for connect to GameViewController
    var viewController : UIViewController?
    
    //takes the screen sizes
    var ekranGenisligi : Int?
    var ekranYuksekligi : Int?
    
    //controlling touching moves
    var touchingControl = false
    var timer: Timer?
    
    //beginning at the scene
    override func didMove(to view: SKView) {
        //takes the screen sizes
        ekranGenisligi = Int(self.size.width)
        ekranYuksekligi = Int(self.size.height)
        
        if let tempAnaKarakter = self.childNode(withName: "anaKarakter") as? SKSpriteNode {
            anaKarakter = tempAnaKarakter
            anaKarakter.isUserInteractionEnabled = true
        }
        if let tempSariDaire = self.childNode(withName: "sariDaire") as? SKSpriteNode {
            sariDaire = tempSariDaire
        }
        if let tempKirmiziUcgen = self.childNode(withName: "kirmiziUcgen") as? SKSpriteNode {
            kirmiziUcgen = tempKirmiziUcgen
        }
        if let tempSiyahKare = self.childNode(withName: "siyahKare") as? SKSpriteNode {
            siyahKare = tempSiyahKare
        }
        if let tempSkorLabel = self.childNode(withName: "skorLabel") as? SKLabelNode {
            skorLabel = tempSkorLabel
            skorLabel.text = "Skor: 0"
        }
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector (GameScene.hareketEttir), userInfo: nil, repeats: true)
    }
    
    @objc func hareketEttir() {
        
        if touchingControl {
            print("Hareket Ettir çalıştı: touchingControl: \(touchingControl)")
            let yukariHareket: SKAction = SKAction.moveBy(x: 0, y: +20, duration: 1)
            anaKarakter.run(yukariHareket)
        } else {
            let asagiHareket: SKAction = SKAction.moveBy(x: 0, y: -20, duration: 1)
            anaKarakter.run(asagiHareket)
        }
        cisimlerinSerbestHareketi(cisimAdi: siyahKare, cisimHizi: -10)
        cisimlerinSerbestHareketi(cisimAdi: kirmiziUcgen, cisimHizi: -5)
    }
    
    func cisimlerinSerbestHareketi(cisimAdi: SKSpriteNode, cisimHizi: CGFloat){
        if Int(cisimAdi.position.x) < 0 {
            //siyahKare ekranın en soluna gelip ekrandan çıkmışsa,ekranın en soluna "random konuma" atılır
            cisimAdi.position.x = CGFloat(ekranGenisligi! + 20)
            cisimAdi.position.y = -CGFloat(arc4random_uniform(UInt32(ekranYuksekligi!)))
        }
        else{
            let solaHareket:SKAction = SKAction.moveBy(x: cisimHizi, y: 0 ,duration: 6)
            cisimAdi.run(solaHareket)
        }
    }

    
    func touchDown(atPoint pos : CGPoint) {
        touchingControl = true
        print("ekrana dokundu, touchingControl: \(touchingControl)")
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {
        touchingControl = false
        print("ekranı bıraktı, touchingControl: \(touchingControl)")
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
