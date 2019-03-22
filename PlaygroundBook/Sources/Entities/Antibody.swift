//
//  Guard.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 22/03/19.
//

import Foundation
import GameplayKit

public class Antibody: GKEntity {
    
    weak var entityManager: EntityManager?
    
    init(entityManager: EntityManager, at location: CGPoint = CGPoint.zero) {
        self.entityManager = entityManager
        super.init()
        self.addComponent(SpriteComponent(imageNamed: "💂‍♀️"))
        self.addComponent(DefenseComponent(entityManager: entityManager))
        self.addComponent(PhysicsComponent(for: spriteComponent.node))
        spriteComponent.node.position = location
        spriteComponent.node.physicsBody?.collisionBitMask = CategoryMask.virus.rawValue | CategoryMask.human.rawValue
        spriteComponent.node.physicsBody?.contactTestBitMask = CategoryMask.virus.rawValue
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

