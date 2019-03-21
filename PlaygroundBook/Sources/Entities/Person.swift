//
//  Person.swift
//  PlaygroundBook
//
//  Created by Mateus Rodrigues on 16/03/19.
//

import Foundation
import GameplayKit

enum Gender {
    case male
    case female
}

public class Person: GKEntity {
    
    weak var entityManager: EntityManager?
    
    var name: String
    
    var gender: Gender
    
    var isVacinated = false
    
    var isInfected = false
    
    var wasTouched = false
    
    init(entityManager: EntityManager, name: String, gender: Gender, emoji: String) {
        self.entityManager = entityManager
        self.name = name
        self.gender = gender
        super.init()
        self.addComponent(SpriteComponent(imageNamed: emoji))
        self.addComponent(MovementComponent())
        self.addComponent(PhysicsComponent(for: spriteComponent.node))
        
    }
    
    func infect() {
        if !isVacinated && !isInfected {
            self.isInfected = true
            switch gender {
                case .male:
                    spriteComponent.node.texture = SKTexture(imageNamed: "🧟")
                case .female:
                    spriteComponent.node.texture = SKTexture(imageNamed: "🧟‍♀️")
            }
            let body = physicsComponent.body
            body.categoryBitMask = CategoryMask.zombie.rawValue
            body.collisionBitMask = CategoryMask.human.rawValue | CategoryMask.zombie.rawValue
            body.contactTestBitMask = CategoryMask.human.rawValue
            removeComponent(ofType: MovementComponent.self)
            addComponent(FollowComponent(entityManager: entityManager!))
        }
    }
    
    func vacinate(animate: Bool = false, circle: Bool = false) {
        if self.isVacinated {
            print("Already Vacinated!")
        } else if self.isInfected {
            print("Too Late!")
        } else {
            print("Vacinated")
            self.isVacinated = true
            if circle {
                addComponent(CircleComponent(for: spriteComponent))
                spriteComponent.node.addChild(circleComponent.node)
            }
            if animate {
                let option = Bool.random()
                let emoji = option ? "🤢" : "😢"
                let sick = SKAction.setTexture(SKTexture(imageNamed: emoji))
                let wait = SKAction.wait(forDuration: 2.0)
                let health = SKAction.setTexture(SKTexture(imageNamed: "😀"))
                spriteComponent.node.run(SKAction.sequence([sick, wait, health]))
            }
        }
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

