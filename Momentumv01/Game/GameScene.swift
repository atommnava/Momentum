//
//  GameScene.swift
//  Momentumv01
//
//  Created by Atom Alexander Munoz Nava on 05/07/26.
//

import Foundation
import SpriteKit

final class GameScene: SKScene {
    private let spawnInterval: TimeInterval = 3
    private let spawnActionKey = "spawnPoints"
    public var onPointTouched: (() -> Void)?
    private(set) var isGamePaused = false
    
    override func didMove(to view: SKView)
    {
        backgroundColor = .black
        startSpawningPoints()
    }
    
    private func createPoint()
    {
        let point = MomentumPoint(radius: 40)
        
        point.position = PointSpawner.randomPosition(in: size)
        
        addChild(point)
    }
    
    private func startSpawningPoints()
    {
        guard action(forKey: spawnActionKey) == nil else {
            return
        }
        let spawn = SKAction.run { [weak self] in self?.createPoint() }
        let wait = SKAction.wait(forDuration: spawnInterval)
        let sequence = SKAction.sequence([wait, spawn])
        let repeatForever = SKAction.repeatForever(sequence)
        
        run(repeatForever, withKey: spawnActionKey)
    }
    
    private func handleTouch(at location: CGPoint)
    {
        guard !isGamePaused else { return }
        
        let touchedNodes = nodes(at: location)
        
        for node in touchedNodes {
            if let touchableNode = node as? TouchableNode
            {
                touchableNode.handleTouch()
                onPointTouched?()
                print("Node touched!")
                return
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard !isGamePaused else { return }
        guard let touch = touches.first else { return }
        
        
        let location = touch.location(in: self)
        handleTouch(at: location)
    }
    
    func pauseGame()
    {
        isGamePaused = true
        self.isPaused = true
    }
    
    func resumeGame()
    {
        isGamePaused = false
        self.isPaused = false
    }
}
