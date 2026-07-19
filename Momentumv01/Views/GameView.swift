//
//  GameView.swift
//  Momentumv01
//
//  Created by Atom Alexander Munoz Nava on 04/07/26.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    let difficulty: Difficulty
    let onExit: () -> Void
    
    @State private var experience = ShowExperience()
    @State private var isPaused = false
    @State private var countdown: Int?
    @State private var missedPoints: Int = 0
    @State private var hasStartedGame: Bool = false
    @State private var isGameOver: Bool = false
    
    private let maxLives = 3
    
    private let scene: GameScene = {
        let scene = GameScene(size: CGSize(width: 390, height: 844))
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene).ignoresSafeArea()
                
            VStack {
                HStack {
                    Text("XP: \(experience.points)")
                        .font(.headline.bold())
                        .foregroundStyle(.white)
                    
                    Text("Fallos: \(missedPoints)/\(maxLives)")
                        .font(.headline.bold())
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Button {
                        if isPaused {
                            startResumeCountDown()
                        } else {
                            isPaused = true
                            scene.pauseGame()                        }
                    } label: {
                        Image(systemName: isPaused ? "play.fill" : "pause.fill")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                            .padding()
                    }
                }
                if let countdown {
                    Text("\(countdown)")
                            .font(.system(size: 90, weight: .black, design: .rounded))
                            .foregroundStyle(.white)
                }
                Spacer()
                
                if isGameOver {
                    gameOverContainer
                }
            }
        }
        .onAppear {
            guard !hasStartedGame else { return }
            scene.onPointTouched = {
                guard !isGameOver else { return }
                experience.add(amount: difficulty.configuration.xpPerPoint)
            }
            scene.onPointExpired = {
                handleMissedPoint()
            }
            
            scene.pauseGame()
            isPaused = true
            
            scene.configure(with: difficulty.configuration)
            
            startCountdown {
                hasStartedGame = true
                isPaused = false
                scene.resumeGame()
                scene.startGame()
            }
        }
    }
    
    private var gameOverContainer: some View {
        VStack(spacing: 20) {
            VStack(spacing: 6) {
                Text("¡PERDISTE!")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Text("XP Final: \(experience.points)")
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.8))
            }
            
            Button {
                onExit()
            } label: {
                Text("Volver al menú")
                                   .font(.headline.bold())
                                   .foregroundStyle(.white)
                                   .frame(maxWidth: .infinity)
                                   .frame(height: 52)
                                   .background(Color.momentumOrange)
                                   .clipShape(RoundedRectangle(cornerRadius: 18))
            }
        }
        .padding(24)
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
    }
    
    private func handleMissedPoint()
    {
        guard !isGameOver else { return }
        missedPoints += 1
        
        if missedPoints >= 3 {
            triggerGameOver()
        }
    }
    
    private func triggerGameOver()
    {
        isGameOver = true
        isPaused = true
        scene.endGame()
    }
    
    private func startResumeCountDown()
    {
        countdown = 3
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true)
        { timer in
            guard let current = countdown else {
                timer.invalidate()
                return
            }
            
            if current > 1
            {
                countdown = current - 1
               
            } else
            {
                timer.invalidate()
                countdown = nil
                isPaused = false
               
                scene.resumeGame()
            }
        }
    }
    
    private func startCountdown(completion: @escaping () -> Void)
    {
        countdown = 3
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            guard let current = countdown else {
                timer.invalidate()
                return
            }
            
            if current > 1 {
                countdown = current - 1
            } else {
                timer.invalidate()
                countdown = nil
                completion()
            }
        }
    }
}
