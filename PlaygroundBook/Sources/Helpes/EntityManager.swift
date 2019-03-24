//
//  EntityManager.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 19/03/19.
//

import SpriteKit
import GameplayKit

public class EntityManager {
    
    public let scene: SKScene
    private var entities: Set<GKEntity>
    
    init(scene: SKScene) {
        self.scene = scene
        entities = Set<GKEntity>()
    }
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        if let node = entity.component(ofType: SpriteComponent.self)?.node {
            node.alpha = 0.0
            scene.addChild(node)
            node.run(SKAction.fadeIn(withDuration: 0.5))
        }
        
    }
    
    func add(_ entities: [GKEntity]) {
        entities.forEach { [weak self] entity in
            self?.add(entity)
        }
    }
    
    func remove(_ entity: GKEntity) {
        guard let node = entity.component(ofType: SpriteComponent.self)?.node else {
            return
        }
        
        node.run(SKAction.fadeOut(withDuration: 0.5)) {
            node.removeFromParent()
        }
        entities.remove(entity)
    }
    
    func update(_ deltaTime: CFTimeInterval) {
        entities.forEach { (entity) in
            entity.update(deltaTime: deltaTime)
        }
    }
    
    func getComponents<T: GKComponent>(type: T.Type) -> [T] {
        var components = [T]()
        for entity in entities {
            if let component = entity.component(ofType: T.self) {
                components.append(component)
            }
        }
        return components
    }
    
}
