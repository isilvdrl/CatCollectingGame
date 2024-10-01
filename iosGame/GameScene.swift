//
//  GameScene.swift
//  iosGame
//
//  Created by IŞIL VARDARLI on 24.09.2024.
//
import UIKit
import SpriteKit
import GameplayKit

enum CarpismaTipi:UInt32 {
    case anaKarakter = 1
    case sariDaire = 2
    case kirmiziUcgen = 3
    case siyahKare = 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var anaKarakter: SKSpriteNode = SKSpriteNode()
    var sariDaire:SKSpriteNode = SKSpriteNode()
    var kirmiziUcgen:SKSpriteNode = SKSpriteNode()
    var siyahKare:SKSpriteNode = SKSpriteNode()
    var skorLabel:SKLabelNode = SKLabelNode()
    var totalSkor: Int = 0
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
        
        self.physicsWorld.contactDelegate = self
        
        if let tempAnaKarakter = self.childNode(withName: "anaKarakter") as? SKSpriteNode {
            anaKarakter = tempAnaKarakter
            anaKarakter.physicsBody?.categoryBitMask = CarpismaTipi.anaKarakter.rawValue
            anaKarakter.physicsBody?.collisionBitMask = CarpismaTipi.sariDaire.rawValue | CarpismaTipi.kirmiziUcgen.rawValue | CarpismaTipi.siyahKare.rawValue
            anaKarakter.physicsBody?.contactTestBitMask = CarpismaTipi.sariDaire.rawValue | CarpismaTipi.kirmiziUcgen.rawValue | CarpismaTipi.siyahKare.rawValue
        }
        if let tempSariDaire = self.childNode(withName: "sariDaire") as? SKSpriteNode {
            sariDaire = tempSariDaire
            sariDaire.physicsBody?.categoryBitMask = CarpismaTipi.sariDaire.rawValue
            sariDaire.physicsBody?.collisionBitMask = CarpismaTipi.anaKarakter.rawValue
            sariDaire.physicsBody?.contactTestBitMask = CarpismaTipi.anaKarakter.rawValue
        }
        if let tempKirmiziUcgen = self.childNode(withName: "kirmiziUcgen") as? SKSpriteNode {
            kirmiziUcgen = tempKirmiziUcgen
            kirmiziUcgen.physicsBody?.categoryBitMask = CarpismaTipi.kirmiziUcgen.rawValue
            kirmiziUcgen.physicsBody?.collisionBitMask = CarpismaTipi.anaKarakter.rawValue
            kirmiziUcgen.physicsBody?.contactTestBitMask = CarpismaTipi.anaKarakter.rawValue
        }
        if let tempSiyahKare = self.childNode(withName: "siyahKare") as? SKSpriteNode {
            siyahKare = tempSiyahKare
            siyahKare.physicsBody?.categoryBitMask = CarpismaTipi.siyahKare.rawValue
            siyahKare.physicsBody?.collisionBitMask = CarpismaTipi.anaKarakter.rawValue
            siyahKare.physicsBody?.contactTestBitMask = CarpismaTipi.anaKarakter.rawValue
        }
        if let tempSkorLabel = self.childNode(withName: "skorLabel") as? SKLabelNode {
            skorLabel = tempSkorLabel
            skorLabel.text = "Skor: 0"
        }
        randomStart(cisimAdi: siyahKare, cisimHizi: -10)
        randomStart(cisimAdi: kirmiziUcgen, cisimHizi: -5)
        randomStart(cisimAdi: sariDaire, cisimHizi: -8)
        
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
        cisimlerinSerbestHareketi(cisimAdi: sariDaire, cisimHizi: -8)
    }
    
    func cisimlerinSerbestHareketi(cisimAdi: SKSpriteNode, cisimHizi: CGFloat){
        if Int(cisimAdi.position.x) < 0 {
            //cisim ekranın en soluna gelip ekrandan çıkmışsa,ekranın sağına "random konuma" atılır
            randomStart(cisimAdi: cisimAdi ,cisimHizi: cisimHizi)
        }
        else{
            let solaHareket:SKAction = SKAction.moveBy(x: cisimHizi, y: 0 ,duration: 6)
            cisimAdi.run(solaHareket)
        }
    }
    
    func randomStart(cisimAdi: SKSpriteNode,cisimHizi: CGFloat){
        cisimAdi.position.x = CGFloat(ekranGenisligi! + 20)
        cisimAdi.position.y = -CGFloat(arc4random_uniform(UInt32(ekranYuksekligi!)))
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
    
    //çarpışma kontrol
    func didBegin(_ contact: SKPhysicsContact){
        let basaAl:SKAction = SKAction.moveBy(x : CGFloat(ekranGenisligi! + 20), y : -CGFloat(arc4random_uniform(UInt32(ekranYuksekligi!))), duration: 0.02)
        //siyahKare
        if contact.bodyA.categoryBitMask == CarpismaTipi.anaKarakter.rawValue && contact.bodyB.categoryBitMask == CarpismaTipi.siyahKare.rawValue{
            anaKarakter.run(basaAl)
            //son skor skor sayfasına aktarılır
            let d = UserDefaults.standard
            d.set(totalSkor, forKey: "lastSkor")
            //sayac durdurulur ve skor sayfasına geçiş sağlanır
            timer?.invalidate()
            self.viewController?.performSegue(withIdentifier: "gameToSkor", sender: nil)
        }
        if contact.bodyA.categoryBitMask == CarpismaTipi.siyahKare.rawValue && contact.bodyB.categoryBitMask == CarpismaTipi.anaKarakter.rawValue{
            anaKarakter.run(basaAl)
            let d = UserDefaults.standard
            d.set(totalSkor, forKey: "lastSkor")
            timer?.invalidate()
            self.viewController?.performSegue(withIdentifier: "gameToSkor", sender: nil)
        }
        //sariDaire
        if contact.bodyA.categoryBitMask == CarpismaTipi.anaKarakter.rawValue && contact.bodyB.categoryBitMask == CarpismaTipi.sariDaire.rawValue{
            sariDaire.run(basaAl)
            totalSkor += 20
            skorLabel.text = "Skor: \(totalSkor)"
        }
        if contact.bodyA.categoryBitMask == CarpismaTipi.sariDaire.rawValue && contact.bodyB.categoryBitMask == CarpismaTipi.anaKarakter.rawValue{
            sariDaire.run(basaAl)
            totalSkor += 20
            skorLabel.text = "Skor: \(totalSkor)"
        }
        //kirmiziUcgen
        if contact.bodyA.categoryBitMask == CarpismaTipi.anaKarakter.rawValue && contact.bodyB.categoryBitMask == CarpismaTipi.kirmiziUcgen.rawValue{
            kirmiziUcgen.run(basaAl)
            totalSkor += 50
            skorLabel.text = "Skor: \(totalSkor)"
        }
        if contact.bodyA.categoryBitMask == CarpismaTipi.kirmiziUcgen.rawValue && contact.bodyB.categoryBitMask == CarpismaTipi.anaKarakter.rawValue{
            kirmiziUcgen.run(basaAl)
            totalSkor += 50
            skorLabel.text = "Skor: \(totalSkor)"
        }
        
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
