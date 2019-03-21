//
//  MovementComponent.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 16/03/19.
//

import GameplayKit

public class MovementComponent: GKAgent2D, GKAgentDelegate {
    
    var isTarget = false
    
    override init() {
        super.init()
        delegate = self
        maxAcceleration = 50
        maxSpeed = 50
        self.position = vector_float2(point: CGPoint.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func agentWillUpdate(_ agent: GKAgent) {
        guard let spriteNode = entity?.component(ofType: SpriteComponent.self)?.node else {
            fatalError("Agent has no SpriteComponent.")
        }
        self.position = vector_float2(point: spriteNode.position)
    }
    
    public func agentDidUpdate(_ agent: GKAgent) {
        guard let spriteNode = entity?.component(ofType: SpriteComponent.self)?.node else {
            fatalError("Agent has no SpriteComponent.")
        }
        spriteNode.position = CGPoint(vector: position)
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
//        if behavior == nil {
//            let wander = GKGoal(toWander: 0.1)
//            self.behavior = GKBehavior(goal: wander, weight: 500)
//        }
    }
    
}
