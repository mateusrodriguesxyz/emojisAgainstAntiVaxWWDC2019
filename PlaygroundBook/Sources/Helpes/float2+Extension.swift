//
//  float2+Extension.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 19/03/19.
//

import CoreGraphics
import simd

extension float2 {
    public init(point: CGPoint) {
        let x = Float(point.x)
        let y = Float(point.y)
        self.init(x: x, y: y)
    }
}
