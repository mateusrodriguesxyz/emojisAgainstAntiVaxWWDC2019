//
//  GKEntity+Extension.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 19/03/19.
//

import GameplayKit

extension GKEntity {
    
    var spriteComponent: SpriteComponent {
        guard let component = self.component(ofType: SpriteComponent.self) else {
            fatalError("\(SpriteComponent.self) was not found is \(self)")
        }
        return component
    }
    
    var physicsComponent: PhysicsComponent {
        guard let component = self.component(ofType: PhysicsComponent.self) else {
            fatalError("\(PhysicsComponent.self) was not found is \(self)")
        }
        return component
    }
    
    var circleComponent: CircleComponent {
        guard let component = self.component(ofType: CircleComponent.self) else {
            fatalError("\(CircleComponent.self) was not found is \(self)")
        }
        return component
    }
    
    var humanComponent: HumanComponent {
        guard let component = self.component(ofType: HumanComponent.self) else {
            fatalError("\(HumanComponent.self) was not found is \(self)")
        }
        return component
    }
    
    var followComponent: ZombieComponent {
        guard let component = self.component(ofType: ZombieComponent.self) else {
            fatalError("\(ZombieComponent.self) was not found is \(self)")
        }
        return component
    }
    
}
