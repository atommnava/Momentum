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
            return GameConfiguration(spawnInterval: 1.5, pointLifeTime: 1.5, pointRadius: 40, xpPerPoint: 10)
        case .normal:
            return GameConfiguration(spawnInterval: 1.0, pointLifeTime: 1.0, pointRadius: 34, xpPerPoint: 15)
        case .experienced:
            return GameConfiguration(spawnInterval: 0.7, pointLifeTime: 0.7, pointRadius: 28, xpPerPoint: 30)
        case .madmax:
            return GameConfiguration(spawnInterval: 0.5, pointLifeTime: 0.5, pointRadius: 28, xpPerPoint: 30)
        }
    }
}
