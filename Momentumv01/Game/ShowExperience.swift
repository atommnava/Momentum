//
//  ShowExperience.swift
//  Momentumv01
//
//  Created by Atom Alexander Munoz Nava on 06/07/26.
//

import Foundation

struct ShowExperience {
    private(set) var points: Int = 0
    
    mutating func add(_ amount: Int)
    {
        points += amount
    }
    
    mutating func reset()
    {
        points = 0
    }
}
