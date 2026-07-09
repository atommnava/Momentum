//
//  Difficulty.swift
//  Momentumv01
//
//  Created by Atom Alexander Munoz Nava on 08/07/26.
//

internal import CoreFoundation

extension Difficulty {
    var configuration: GameConfiguration {
        switch self {
        case .easy:
            return GameConfiguration(spawnInterval: 2.0, pointLifeTime: 2.0, pointRadius: 40, xpPerPoint: 100)
        case .normal:
            return GameConfiguration(spawnInterval: 1.0, pointLifeTime: 1.0, pointRadius: 34, xpPerPoint: 200)
        case .experienced:
            return GameConfiguration(spawnInterval: 0.8, pointLifeTime: 0.8, pointRadius: 28, xpPerPoint: 275)
        }
    }
}
