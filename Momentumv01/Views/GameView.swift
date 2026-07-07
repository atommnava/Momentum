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
    
    @State private var isPaused = false
    @State private var experience = ShowExperience()
    
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
                        isPaused.toggle()
                        
                        if isPaused {
                            scene.pauseGame()
                        } else {
                            scene.resumeGame()
                        }
                    } label: {
                        Image(systemName: isPaused ? "play.fill" : "pause.fill")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                            .padding()
                    }
                }
                
                Spacer()
            }
        }
        .onAppear {
            scene.onPointTouched = { experience.add(1) }
        }
    }
}
