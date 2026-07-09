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
                    Button {
                        onExit()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                            .padding()
                    }
                    
                    Spacer()
                    
                    Text("XP: \(experience.points)")
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
            }
        }
        .onAppear {
            scene.configure(with: difficulty.configuration)
            scene.onPointTouched = {
                experience.add(amount: difficulty.configuration.xpPerPoint) }
        }
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
}
