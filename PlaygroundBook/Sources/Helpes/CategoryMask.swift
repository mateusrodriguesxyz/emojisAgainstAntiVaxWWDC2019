//
//  CategoryMask.swift
//  Book_Sources
//
//  Created by Mateus Rodrigues on 20/03/19.
//

import Foundation

public enum CategoryMask: UInt32 {
    case human = 0b0001
    case zombie = 0b0010
    case virus = 0b0100
}
