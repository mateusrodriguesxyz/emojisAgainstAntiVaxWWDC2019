//
//  SceneOne.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 22/03/19.
//

import SpriteKit
import GameplayKit

public class SceneOne: SKScene {
    
    private var entityManager: EntityManager!
    
    private var lastUpdateTimeInterval = TimeInterval(0)
    
    private var filledRange = [PointRange]()
    
    let emojis = ["🧑🏽", "👩🏻‍🦱", "👨🏿‍🦱", "🧔🏼", "🧟", "🧟‍♀️", "😀", "🙂", "😢", "🤢", "🤒", "🦠", "😐", "💂", "💂‍♀️"]
    
    override public init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        entityManager = EntityManager(scene: self)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.collisionBitMask = CategoryMask.human.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMove(to view: SKView) {
        backgroundColor = UIColor.white
        physicsWorld.contactDelegate = self
        
        let timer = Timer.scheduledTimer(timeInterval: 0.25, target: self,
                                         selector: #selector(createEmoji),
                                         userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc private func createEmoji() {
        let emoji = SKSpriteNode(imageNamed: emojis.randomElement()!)
        addChild(emoji)
        animate(node: emoji)
        
    }
    
    private func animate(node: SKSpriteNode){
        
        guard let frame = scene?.frame else {
            return
        }
        
        let configuration: [(CGFloat, Double)] = [(0.3, 3.0), (0.4, 4.0), (0.5, 5.0)]
        
        var nodeCopy: SKNode! = node
        nodeCopy.position.y = frame.maxY + 50
        node.position.x = CGFloat.random(in: PointRange(from: frame).rangeX)
        
        guard let (scale, duration) = configuration.randomElement() else {
            return
        }
        nodeCopy.setScale(scale)
        
        let action = SKAction.moveTo(y: frame.minY, duration: duration)
        node.run(action ,completion: {
            nodeCopy.removeFromParent()
            nodeCopy = nil
        })
        
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let location = touches.first?.location(in: self) else {
            return
        }
        let node = self.atPoint(location)
        if let person = node.entity as? Person {
            person.vacinate(animate: true, circle: false)
        }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        entityManager.update(deltaTime)
    }
    
    private func setValidSpritePosition(entities: [GKEntity], offset: CGFloat, initialRanges: [PointRange]) {
        
        if scene!.frame.width == 0 { return }
        
        var lastPosition: CGPoint = .zero
        var ranges = initialRanges
        
        entities.forEach { entity in
            let spriteComponent = entity.spriteComponent
            let node = spriteComponent.node
            var position = lastPosition
            
            while self.checkPositionInRange(position: position, ranges: ranges) {
                position = CGPoint.random(for: scene!.frame, offset: 50)
            }
            
            node.position = position
            lastPosition = node.position
            ranges.append(spriteComponent.getPointRange(offset: offset))
        }
        
        filledRange = ranges
    }
    
    private func checkPositionInRange(position: CGPoint, ranges: [PointRange]) -> Bool {
        for range in ranges {
            if range.contains(position) {
                return true
            }
        }
        return false
    }
    
}

extension SceneOne: SKPhysicsContactDelegate {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
    }
    
}
