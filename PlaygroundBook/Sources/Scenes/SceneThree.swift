//
//  FirstScene.swift
//  LiveViewTestApp
//
//  Created by Mateus Rodrigues on 21/03/19.
//

import SpriteKit
import GameplayKit

public class SceneThree: SKScene {
    
    private var entityManager: EntityManager!
    
    private var lastUpdateTimeInterval = TimeInterval(0)
    
    private var filledRange = [PointRange]()
    
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
        //createEmojis(5)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {
            return
        }
        let node = self.atPoint(location)
        if let person = node.entity as? Person {
            if !person.isVacinated {
                showSyringe(for: person)
            }
        }
    }
    
    func showSyringe(for person: Person) {
        let syringe = SKSpriteNode(imageNamed: "vaccine")
        let node = person.spriteComponent.node
        syringe.position = node.position.move(50, .left).move(50, .up)
        syringe.alpha = 0.0
        syringe.setScale(0.5)
        addChild(syringe)
        syringe.anchorPoint = CGPoint(x: 1.0, y: 0)
        let show = SKAction.fadeIn(withDuration: 0.25)
        let inject = SKAction.move(to: node.position, duration: 0.5)
        let hide = SKAction.fadeOut(withDuration: 0.25)
        let actions = SKAction.sequence([show, inject, hide])
        syringe.run(actions) {
            syringe.removeFromParent()
            person.vacinate(animate: true, circle: false)
        }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        entityManager.update(deltaTime)
    }
    
    public func createEmojis(_ total: Int) {
        var people = [Person]()
        for i in 0 ... total {
            let person = Person(entityManager: entityManager, name: "smile\(i)", gender: .male, emoji: "😐")
            person.humanComponent.wander = true
            people.append(person)
            entityManager.add(person)
        }
        setValidSpritePosition(entities: people, offset: 100, initialRanges: filledRange)
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

extension SceneThree: SKPhysicsContactDelegate {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
    }
    
}

