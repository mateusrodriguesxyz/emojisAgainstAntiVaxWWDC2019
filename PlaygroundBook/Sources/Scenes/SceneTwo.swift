//
//  SceneTwo.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 22/03/19.
//

import SpriteKit
import GameplayKit

public class SceneTwo: SKScene {
    
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
    }
    
    public func start() {
        let virus = Virus(entityManager: entityManager)
        virus.spriteComponent.node.position = CGPoint.zero
        entityManager.add(virus)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {
            return
        }
        let node = self.atPoint(location)
        if let virus = node.entity as? Virus {
            produceAntibodies(for: virus)
        }
    }
    
    func produceAntibodies(for virus: Virus) {
        let virusNode = virus.spriteComponent.node
        let antibody1 = Antibody(entityManager: entityManager, at: virusNode.position.move(200, .up))
        let antibody2 = Antibody(entityManager: entityManager, at: virusNode.position.move(200, .down))
        let antibody3 = Antibody(entityManager: entityManager, at: virusNode.position.move(200, .left))
        let antibody4 = Antibody(entityManager: entityManager, at: virusNode.position.move(200, .right))
        entityManager.add(antibody1)
        entityManager.add(antibody2)
        entityManager.add(antibody3)
        entityManager.add(antibody4)
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

extension SceneTwo: SKPhysicsContactDelegate {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        if let virus = contact.bodyA.node?.entity as? Virus {
            entityManager.remove(virus)
            return
        }
        
        if let virus = contact.bodyB.node?.entity as? Virus {
            entityManager.remove(virus)
            return
        }
        
    }
    
}
