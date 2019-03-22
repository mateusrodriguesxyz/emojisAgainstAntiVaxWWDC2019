//
//  VirusComponent.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 22/03/19.
//

import GameplayKit

public class VirusComponent: GKAgent2D, GKAgentDelegate {
    
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
        if behavior == nil {
            let wander = GKGoal(toWander: 10)
            let stop = GKGoal(toReachTargetSpeed: 0)
            self.behavior = GKBehavior(goals: [wander, stop], andWeights: [100, 1])
        }
    }
    
}
