//
//  PhysicsComponent.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 19/03/19.
//

import SpriteKit
import GameplayKit

public class PhysicsComponent: GKComponent {
    
    var body: SKPhysicsBody
    
    init(for node: SKNode) {
        self.body = SKPhysicsBody(circleOfRadius: node.frame.width/2)
        self.body.categoryBitMask = CategoryMask.human.rawValue
        self.body.contactTestBitMask = CategoryMask.zombie.rawValue
        self.body.collisionBitMask = ~CategoryMask.zombie.rawValue
        self.body.affectedByGravity = false
        super.init()
    }
    
    public override func didAddToEntity() {
        if let node = entity?.component(ofType: SpriteComponent.self)?.node {
            node.physicsBody = body
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
