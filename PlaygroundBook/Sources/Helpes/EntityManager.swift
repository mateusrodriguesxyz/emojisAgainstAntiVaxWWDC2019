//
//  EntityManager.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 19/03/19.
//

import SpriteKit
import GameplayKit

public class EntityManager {
    
    private let scene: SKScene
    private var entities: Set<GKEntity>
    
    init(scene: SKScene) {
        self.scene = scene
        entities = Set<GKEntity>()
    }
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        if let node = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(node)
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
        
        node.removeFromParent()
        
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
