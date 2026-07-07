//
//  ContentView.swift
//  Reflexity
//
//  Created by Atom Alexander Munoz Nava on 04/07/26.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @State private var showDifficulties = false
    @State private var selectedDifficulty: Difficulty?
    
    var body: some View {
        ZStack {
            if let difficulty = selectedDifficulty {
                GameView(difficulty: difficulty)
            } else {
                mainMenu
            }
        }
    }
    
    private var mainMenu: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                            VStack(spacing: 6) {
                                Text("Momentum")
                                    .font(.system(size: 40, weight: .black, design: .rounded))
                                    .foregroundStyle(.white)
                                    .tracking(-1)
                                
                                Text("Prueba tu Cerebro")
                                    .font(.headline)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.top, 70)
                            
                            Spacer()
                            
                            VStack(spacing: 16) {
                                Button {
                                    withAnimation(.spring()) {
                                        showDifficulties.toggle()
                                    }
                                } label: {
                                    Text("Nuevo Juego")
                                        .font(.title3.bold())
                                        .foregroundStyle(.black)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 60)
                                        .background(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 22))
                                }
                                
                                if showDifficulties {
                                    VStack(spacing: 12) {
                                        DifficultyButton(title: Difficulty.easy.rawValue) {
                                            selectedDifficulty = .easy
                                        }
                                        
                                        DifficultyButton(title: Difficulty.normal.rawValue) {
                                            selectedDifficulty = .normal
                                        }
                                        
                                        
                                        DifficultyButton(title: Difficulty.experienced.rawValue) {
                                            selectedDifficulty = .experienced
                                        }
                                    }
                                    .transition(.move(edge: .bottom).combined(with: .opacity))
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.bottom, 85)
                        }
        }
    }
}

#Preview {
    ContentView()
}
