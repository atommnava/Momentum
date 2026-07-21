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
    @State private var scoreFinal: Int = 0
    @State private var animateScore: Bool = false
    @State private var rotateGlow: Bool = false
    
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
                if !isGameOver {
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
                                scene.pauseGame()
                            }
                        } label: {
                            Image(systemName: isPaused ? "play.fill" : "pause.fill")
                                .font(.title2.bold())
                                .foregroundStyle(.white)
                                .padding()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
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
            if isGameOver {
                scoreBadge
            }
        }
        .onAppear {
            guard !hasStartedGame else { return }
            scene.onPointTouched = {
                guard !isGameOver else { return }
                experience.add(amount: difficulty.configuration.xpPerPoint)
                scoreFinal += 1
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
                
                Text("XP: \(experience.points)")
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
    
    private var scoreBadge: some View {
        ZStack {
            // Halo difuso de fondo
                    Circle()
                        .fill(Color.momentumOrange.opacity(0.35))
                        .frame(width: 240, height: 240)
                        .blur(radius: 45)
                    
                    // Anillo de brillo rotando (la "estela")
                    Circle()
                        .stroke(
                            AngularGradient(
                                colors: [.clear, Color.momentumOrange, .white, Color.momentumOrange, .clear],
                                center: .center
                            ),
                            lineWidth: 4
                        )
                        .frame(width: 175, height: 175)
                        .rotationEffect(.degrees(rotateGlow ? 360 : 0))
                        .animation(.linear(duration: 3).repeatForever(autoreverses: false), value: rotateGlow)
                    
                    // Cuerpo del badge
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.momentumOrange.opacity(0.95), Color.momentumOrange.opacity(0.55)],
                                center: .center,
                                startRadius: 5,
                                endRadius: 100
                            )
                        )
                        .frame(width: 160, height: 160)
                        .overlay(
                            Circle()
                                .stroke(.white.opacity(0.6), lineWidth: 2)
                        )
                        .shadow(color: Color.momentumOrange.opacity(0.7), radius: 25)
                    
                    VStack(spacing: 2) {
                        Text("\(scoreFinal)")
                            .font(.system(size: 56, weight: .black, design: .rounded))
                            .foregroundStyle(.white)
                            .contentTransition(.numericText())
                        
                        Text("PUNTAJE FINAL")
                            .font(.caption2.bold())
                            .tracking(1.5)
                            .foregroundStyle(.white.opacity(0.85))
                    }
                }
                .scaleEffect(animateScore ? 1 : 0.5)
                .opacity(animateScore ? 1 : 0)
                .onAppear {
                    withAnimation(.spring(response: 0.55, dampingFraction: 0.65)) {
                        animateScore = true
                    }
                    rotateGlow = true
        }
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
