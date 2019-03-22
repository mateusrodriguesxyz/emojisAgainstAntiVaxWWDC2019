//
//  DefenseComponent.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 22/03/19.
//

import GameplayKit

public class DefenseComponent: GKAgent2D, GKAgentDelegate {
    
    let entityManager: EntityManager
    
    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()
        delegate = self
        maxAcceleration = 100
        maxSpeed = 100
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
    
    func closestVirusComponent() -> GKAgent2D? {
        
        var closestMoveComponent: VirusComponent? = nil
        var closestDistance = CGFloat(0)
        
        let virusComponents = entityManager.getComponents(type: VirusComponent.self)

        for component in virusComponents {
            let distance = CGPoint(vector: component.position - position).length()
            if closestMoveComponent == nil || distance < closestDistance {
                closestMoveComponent = component
                closestDistance = distance
            }
        }
        return closestMoveComponent
        
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let target = closestVirusComponent() as? VirusComponent else {
            let wander = GKGoal(toWander: 10)
            let stop = GKGoal(toReachTargetSpeed: 0)
            self.behavior = GKBehavior(goals: [wander, stop], andWeights: [100, 1])
            return
        }
        let seek = GKGoal(toSeekAgent: target)
        self.behavior = GKBehavior(goal: seek, weight: 1000)
    }
    
}
