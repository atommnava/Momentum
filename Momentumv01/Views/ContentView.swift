//
//  ContentView.swift
//  Reflexity
//
//  Created by Atom Alexander Munoz Nava on 04/07/26.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    //@State private var showDifficulties = false
    @State private var selectedDifficulty: Difficulty?
    @State private var showDifficultySheet: Bool = false
    
    var body: some View {
        ZStack {
            if let difficulty = selectedDifficulty {
                GameView(difficulty: difficulty) {
                    selectedDifficulty = nil
                    showDifficultySheet = false
                }
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
                        showDifficultySheet = true
                    }
                    label: {
                        Text("Nuevo Juego")
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.momentumOrange)
                            .clipShape(RoundedRectangle(cornerRadius: 22))
                    }
                    Button {
                        // Estadistica = true
                    }
                    label: {
                        Text("Estadisticas")
                            .font(.title3.bold())
                                       .foregroundStyle(.white)
                                       .frame(maxWidth: .infinity)
                                       .frame(height: 60)
                                       .background(Color.momentumOrange)
                                       .clipShape(RoundedRectangle(cornerRadius: 22))
                    }
                    Button {
                        // Opciones = true
                    }
                    label: {
                        Text("Opciones")
                            .font(.title3.bold())
                                       .foregroundStyle(.white)
                                       .frame(maxWidth: .infinity)
                                       .frame(height: 60)
                                       .background(Color.momentumOrange)
                                       .clipShape(RoundedRectangle(cornerRadius: 22))
                    }
                }
                
                .padding(.horizontal, 24)
                .padding(.bottom, 85)
            }
        }
        .sheet(isPresented: $showDifficultySheet) {
            DifficultySelectionView {
                difficulty in selectedDifficulty = difficulty
                showDifficultySheet = false
            }
        }
    }
    
}

#Preview {
    ContentView()
}
