//
//  FollowComponent.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 19/03/19.
//

import GameplayKit

public class FollowComponent: GKAgent2D, GKAgentDelegate {
    
    static var beingFollow = Set<MovementComponent>()
    
    static var vacinatedPeople = Set<GKEntity>()
    
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
    
    func closestMoveComponent() -> GKAgent2D? {
        
        var closestMoveComponent: MovementComponent? = nil
        var closestDistance = CGFloat(0)
        
        let movementComponents = entityManager.getComponents(type: MovementComponent.self)
        
        let targets = movementComponents.filter { (component) -> Bool in
            let person = component.entity as! Person
            return FollowComponent.vacinatedPeople.contains(person) ? false : true
        }
        
        for component in targets {
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
        
        guard let target = closestMoveComponent() as? MovementComponent else {
            let wander = GKGoal(toWander: 10)
            let stop = GKGoal(toReachTargetSpeed: 0)
            self.behavior = GKBehavior(goals: [wander, stop], andWeights: [100, 1])
            return
        }
        let seek = GKGoal(toSeekAgent: target)
        self.behavior = GKBehavior(goal: seek, weight: 1000)
        
        
        
    }
    
}
