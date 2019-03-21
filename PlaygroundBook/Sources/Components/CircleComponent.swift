//
//  CircleComponent.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 19/03/19.
//

import SpriteKit
import GameplayKit

public class CircleComponent: GKComponent {
    
    var node: SKShapeNode
    
    private var radius: CGFloat
    
    init(for spriteComponent: SpriteComponent) {
        self.radius = spriteComponent.node.frame.width+10
        self.node = SKShapeNode(circleOfRadius: radius)
        self.node.strokeColor = #colorLiteral(red: 0.2267882526, green: 0.7793400884, blue: 0.3739308119, alpha: 1)
        self.node.lineWidth = 5
        self.node.position = CGPoint.zero
        super.init()
    }
    
    public override func didAddToEntity() {
        self.node.entity = entity
        if let physicsComponent = entity?.physicsComponent {
            let body = SKPhysicsBody(circleOfRadius: radius/2)
            body.affectedByGravity = false
            body.categoryBitMask = CategoryMask.human.rawValue
            body.contactTestBitMask = CategoryMask.zombie.rawValue
            body.collisionBitMask = ~CategoryMask.zombie.rawValue
            physicsComponent.body = body
            entity?.spriteComponent.node.physicsBody = physicsComponent.body
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
