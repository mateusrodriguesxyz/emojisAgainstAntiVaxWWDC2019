//
//  Virus.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 22/03/19.
//

import Foundation
import GameplayKit

public class Virus: GKEntity {
    
    weak var entityManager: EntityManager?
    
    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()
        self.addComponent(SpriteComponent(imageNamed: "🦠"))
        self.addComponent(VirusComponent())
        self.addComponent(PhysicsComponent(for: spriteComponent.node))
        spriteComponent.node.physicsBody?.categoryBitMask = CategoryMask.virus.rawValue
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
