//
//  DifficultyOptionButtonView.swift
//  Momentumv01
//
//  Created by Atom Alexander Munoz Nava on 09/07/26.
//

import SwiftUI

struct DifficultyOptionButtonView: View {
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack
            {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline.bold())
                        .foregroundStyle(.black)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.7))
                }
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white.opacity(0.7))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
    }
}
