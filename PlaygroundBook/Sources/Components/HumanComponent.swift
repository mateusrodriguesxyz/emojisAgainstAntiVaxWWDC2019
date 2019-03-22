//
//  MovementComponent.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 16/03/19.
//

import GameplayKit

public class HumanComponent: GKAgent2D, GKAgentDelegate {
    
    var isTarget = false
    
    var wander = false
    
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
        guard let node = entity?.spriteComponent.node else {
            return
        }
        self.position = vector_float2(point: node.position)
    }
    
    public func agentDidUpdate(_ agent: GKAgent) {
        guard let node = entity?.spriteComponent.node else {
            return
        }
        node.position = CGPoint(vector: position)
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        if behavior == nil && wander {
            let wander = GKGoal(toWander: 10)
            let stop = GKGoal(toReachTargetSpeed: 0)
            self.behavior = GKBehavior(goals: [wander, stop], andWeights: [100, 1])
        }
        if !wander {
            let stop = GKGoal(toReachTargetSpeed: 0)
            self.behavior = GKBehavior(goal: stop, weight: 1)
        }
    }
    
}
