//
//  DifficultyButton.swift
//  Reflexity
//
//  Created by Atom Alexander Munoz Nava on 04/07/26.
//

import Foundation
import SwiftUI

struct DifficultyButton: View {
    let title: String
    let action: () -> Void
    
    var body : some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.headline.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Color.momentumOrange)
                .clipShape(RoundedRectangle(cornerRadius: 18))
        }
    }
}

