//
//  PointRange.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 20/03/19.
//

import SpriteKit

struct PointRange {
    var rangeX: ClosedRange<CGFloat>
    var rangeY: ClosedRange<CGFloat>
    
    mutating func offset(minX: CGFloat = 0, maxX: CGFloat = 0, minY: CGFloat = 0, maxY: CGFloat = 0) {
        rangeX = rangeX.lowerBound+minX ... rangeX.upperBound+maxX
        rangeY = rangeY.lowerBound+minY ... rangeY.upperBound+maxY
    }
    
    func contains(_ point: CGPoint) -> Bool {
        if self.rangeX.contains(point.x) && self.rangeY.contains(point.y) {
            return true
        } else {
            return false
        }
    }
    
}

extension PointRange {
    init(from frame: CGRect) {
        self.rangeX = frame.minX ... frame.maxX
        self.rangeY = frame.minY ... frame.maxY
    }
}
