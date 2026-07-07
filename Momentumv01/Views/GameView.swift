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
    @State private var experience = ShowExperience()
    
    var body: some View {
        ZStack {
            SpriteView(scene: makeScene()).ignoresSafeArea()
                
            VStack {
                HStack {
                    Text("XP: \(experience.points)")
                        .font(.headline.bold())
                        .foregroundStyle(.white)
                        .padding()
                                           
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
    private func makeScene() -> SKScene
    {
        let scene = GameScene(size: CGSize(width: 390, height: 844))
        scene.scaleMode = .resizeFill
        scene.onPointTouched = {
            experience.add(10)
        }
        return scene
    }
}
