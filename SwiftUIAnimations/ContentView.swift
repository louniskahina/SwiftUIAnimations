//
//  ContentView.swift
//  SwiftUIAnimations
//
//  Created by Kahina Lounis on 24/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShown: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("Transitions")
                .font(.system(.title, weight: .bold))
            if isShown {
                imageView
                    .transition(.slide)
                imageView
                    .transition(.opacity)
                imageView
                    .transition(.scale)
                imageView
                    .transition(.scale.combined(with: .slide))
                imageView
                    .transition(.asymmetric(insertion: .slide, removal: .scale))
                imageView
                    .transition(.move(edge: .top))
            }
            Spacer()
            Button {
                withAnimation {
                    isShown.toggle()
                }
            } label: {
                Text("Show")
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 25)
                    .background(Color.green)
                    .clipShape(Capsule())
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private var imageView: some View {
        Image(systemName: "bird.fill")
            //.resizable()
            .foregroundColor(.blue)
            .scaledToFit()
            .frame(width: 50, height: 50)
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
