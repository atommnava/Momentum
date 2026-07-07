//
//  PointSpawner.swift
//  Momentumv01
//
//  Created by Atom Alexander Munoz Nava on 06/07/26.
//

import Foundation
import SpriteKit

struct PointSpawner {
    static func randomPosition(
        in size: CGSize,
        margin: CGFloat = 70
    ) -> CGPoint {
        let x = CGFloat.random(in: margin...(size.width - margin))
        let y = CGFloat.random(in: margin...(size.height - margin))
        
        return CGPoint(x: x, y: y)
    }
    
}
