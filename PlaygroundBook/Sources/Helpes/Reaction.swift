//
//  Reaction.swift
//  LiveViewTestApp
//
//  Created by Mateus Rodrigues on 21/03/19.
//

import Foundation
import SpriteKit

enum Reaction: Int {
    case health = 0
    case cry = 1
    case sick = 2
    
    static func random() -> Reaction {
        let value = Int.random(in: 0 ... 2)
        return Reaction(rawValue: value)!
    }
    
    func emoji() -> SKTexture {
        let texture: SKTexture
        switch self {
        case .health:
            texture = SKTexture(imageNamed: "😀")
        case .cry:
            texture = SKTexture(imageNamed: "😢")
        case .sick:
            texture = SKTexture(imageNamed: "🤢")
        }
        return texture
    }
    
}
