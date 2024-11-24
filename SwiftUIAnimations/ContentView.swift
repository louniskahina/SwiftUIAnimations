//
//  ContentView.swift
//  SwiftUIAnimations
//
//  Created by Kahina Lounis on 24/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isShown: Bool = false
    @State private var transitionIndex: Int = 0
    
    // Liste des transitions et leurs descriptions
    private let transitions: [(name: String, transition: AnyTransition)] = [
        ("1: Slide", .slide),
        ("2: Opacity", .opacity),
        ("3: Scale", .scale),
        ("4: Scale + Slide", .scale.combined(with: .slide)),
        ("5: Asymmetric (Slide In / Scale Out)", .asymmetric(insertion: .slide, removal: .scale)),
        ("6: Move from Top", .move(edge: .top))
    ]
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            Text("Transitions")
                .font(.system(.title, weight: .bold))
            
            // Titre de la transition actuelle
            if isShown {
                Text("Transition : \(transitions[transitionIndex].name)")
                    .font(.headline)
                    .padding()
            }
            
            // Image avec transition
            ZStack {
                if isShown {
                    imageView
                        .transition(transitions[transitionIndex].transition)
                }
            }
            .frame(height: 150) // Pour conserver l'espace même lorsque l'image est masquée
            
            Spacer()
            
            // Bouton pour afficher / cacher
            Button {
                withAnimation(.easeInOut(duration: 1.5)) { // Animation lente
                    isShown.toggle()
                }
            } label: {
                Text(isShown ? "Hide" : "Show")
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 25)
                    .background(isShown ? Color.red : Color.green)
                    .clipShape(Capsule())
            }
            
            // Bouton pour passer à la transition suivante
            Button {
                withAnimation {
                    transitionIndex = (transitionIndex + 1) % transitions.count
                }
            } label: {
                Text("Next Transition")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
            .padding(.top, 10)
        }
        .padding()
    }
    
    @ViewBuilder
    private var imageView: some View {
        Image(systemName: "bird.fill")
            .foregroundColor(.blue)
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
