//
//  DifficultySelectionView.swift
//  Momentumv01
//
//  Created by Atom Alexander Munoz Nava on 09/07/26.
//

import Foundation
import SwiftUI

struct DifficultySelectionView: View {
    let onSelect: (Difficulty) -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 45, height: 5)
                .padding(.top, 10)
            
            Text("Dificultad seleccionada")
                .font(.title2.bold())
                .foregroundStyle(.white)
            
            VStack(spacing: 12) {
                DifficultyOptionButtonView(title: "Fácil", subtitle: "Te ataqueremos con lo mínimo") {
                    onSelect(.easy)
                }
                
                DifficultyOptionButtonView(title: "Normal", subtitle: "Toma decisiones rápido, te atacaremos") {
                    onSelect(.normal)
                }
                
                DifficultyOptionButtonView(title: "Dificil", subtitle: "Te daremos un reto") {
                    onSelect(.experienced)
                }
                DifficultyOptionButtonView(title: "Madmax", subtitle: "Vas a sufrir") {
                    onSelect(.madmax)
                }
            }
            .padding(.horizontal, 24)
            Spacer()
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.hidden)
        .frame(maxWidth: .infinity)
        .background(Color.black)
    }
}


