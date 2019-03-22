//
//  CGPoint+Extension.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 19/03/19.
//

import CoreGraphics
import simd

extension CGPoint {
    
    public init(vector: float2) {
        let x = CGFloat(vector.x)
        let y = CGFloat(vector.y)
        self.init(x: x, y: y)
    }
    
    public func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    public static func random(for rect: CGRect, offset: CGFloat = 0) -> CGPoint {
        let pointX = CGFloat.random(in: rect.minX + offset ... rect.maxX - offset)
        let pointY = CGFloat.random(in: rect.minY + offset ... rect.maxY - offset)
        return CGPoint(x: pointX, y: pointY)
    }
    
    public func move(_ offset: CGFloat, _ direction: Direction) -> CGPoint {
        var point = self
        switch direction {
        case .left:
            point.x -= offset
        case .right:
            point.x += offset
        case .up:
            point.y += offset
        case .down:
            point.y -= offset
        }
        return point
    }
}
