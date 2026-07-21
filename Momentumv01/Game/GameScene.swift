//
//  GameScene.swift
//  Momentumv01
//
//  Created by Atom Alexander Munoz Nava on 05/07/26.
//

import Foundation
import SpriteKit

final class GameScene: SKScene {
    private let spawnActionKey = "spawnPoints"
    private var gameConfiguration: GameConfiguration?
    public var onPointTouched: (() -> Void)?
    private(set) var isGamePaused = false
    var onPointExpired: (() -> Void)?
    
    override func didMove(to view: SKView)
    {
        backgroundColor = .black
    }
    
    private func createPoint()
    {
        guard let gameConfiguration else { return }
        let point = MomentumPoint(radius: gameConfiguration.pointRadius, lifeTime: gameConfiguration.pointLifeTime) {
            [weak self] in self?.onPointExpired?()
        }
        point.position = PointSpawner.randomPosition(in: size)
        addChild(point)
    }
    
    private func startSpawningPoints()
    {
        guard let gameConfiguration else { return }
        guard action(forKey: spawnActionKey) == nil else {
            return
        }
        let spawn = SKAction.run { [weak self] in self?.createPoint() }
        let wait = SKAction.wait(forDuration: gameConfiguration.spawnInterval)
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
    
    func configure(with configuration: GameConfiguration)
    {
        self.gameConfiguration = configuration
    }
    
    func startGame()
    {
        startSpawningPoints()       
    }
    
    func endGame()
    {
        removeAction(forKey: spawnActionKey)
        removeAllChildren()
        isGamePaused = true
        self.isPaused = true
    }
}
