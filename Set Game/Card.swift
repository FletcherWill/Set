//
//  Card.swift
//  Set Game
//
//  Created by Will Fletcher on 6/25/19.
//  Copyright © 2019 Will Fletcher. All rights reserved.
//

import Foundation

struct Card: CustomStringConvertible {
    
    var description: String {
        return "\(shape.rawValue)\(numShapes.rawValue)\(shading.rawValue)\(color.rawValue)"
    }
    
    let shape: Shape
    let numShapes: NumShapes
    let shading: Shading
    let color: Color
    
    var isDealt = false
    var isSelected = false
    var isMatched = false
    var isHint = false
    
    init(shape: Shape, numShapes: NumShapes, shading: Shading, color: Color) {
        self.shape = shape
        self.numShapes = numShapes
        self.shading = shading
        self.color = color
    }
}

enum Shape: Int {
    case diamond
    case squiggle
    case stadium
}

enum NumShapes: Int {
    case one
    case two
    case three
}

enum Shading: Int {
    case solid
    case striped
    case open
}

enum Color: Int {
    case red
    case green
    case purple
}
