//
//  SpriteComponent.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 16/03/19.
//

import SpriteKit
import GameplayKit

public class SpriteComponent: GKComponent {
    
    var node: SKSpriteNode
    
    init(imageNamed name: String) {
        self.node = SKSpriteNode(imageNamed: name)
        node.setScale(0.5)
        super.init()
    }
    
    public override func didAddToEntity() {
        self.node.entity = entity
    }
    
    func getPointRange(offset: CGFloat) -> PointRange {
        let halfWidth = node.frame.width/2
        let halfHeight = node.frame.height/2
        let minX = node.position.x - halfWidth - offset
        let maxX = node.position.x + halfWidth + offset
        let minY = node.position.y - halfHeight - offset
        let maxY = node.position.y + halfHeight + offset
        
        let spriteRangeX: ClosedRange<CGFloat>  =  minX ... maxX
        let spriteRangeY: ClosedRange<CGFloat>  =  minY ... maxY
        
        return PointRange(rangeX: spriteRangeX, rangeY: spriteRangeY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
