//
//  ContentView.swift
//  SwiftUIAnimations
//
//  Created by Kahina Lounis on 24/11/2024.
//

import SwiftUI

struct ContentView: View {

    @State private var isPopupShown: Bool = false
    @State private var isShown: Bool = false
    @State private var transitionIndex: Int = 0

    private let transitions: [(name: String, transition: AnyTransition)] = [
        ("1: Slide", .slide),
        ("2: Opacity", .opacity),
        ("3: Scale", .scale),
        ("4: Scale + Slide", .scale.combined(with: .slide)),
        (
            "5: Asymmetric (Slide In / Scale Out)",
            .asymmetric(insertion: .slide, removal: .scale)
        ),
        ("6: Move from Top", .move(edge: .top)),
    ]

    // MARK: - Body
    var body: some View {
        ZStack {
            VStack(spacing: 20) {

                Text("Transitions")
                    .font(.system(.title, weight: .bold))

                if isShown {
                    Text("Transition : \(transitions[transitionIndex].name)")
                        .font(.headline)
                        .padding()
                }

                ZStack {
                    if isShown {
                        imageView
                            .transition(transitions[transitionIndex].transition)
                    }
                }
                .frame(height: 150)

                Spacer()

                Button {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        isShown.toggle()
                    }
                } label: {
                    Text(isShown ? "Hide" : "Show")
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 25)
                        .background(isShown ? Color.gray : Color.yellow)
                        .clipShape(Capsule())
                }

                Button {
                    withAnimation {
                        transitionIndex =
                            (transitionIndex + 1) % transitions.count
                    }
                } label: {
                    Text("Next Transition")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.mint)
                        .clipShape(Capsule())
                }
                .padding(.top, 10)
            }
            if isPopupShown {
                popupView
            }
        }
        .padding()
        .onAppear {
            checkAndShowPopup()
        }
    }

    // MARK: - Image View
    @ViewBuilder
    private var imageView: some View {
        Image(systemName: "bird.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .foregroundColor(.gray)
    }

    // MARK: - Pop-up View
    private var popupView: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Bienvenue dans l'application !")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(
                    "Découvrez les transitions de SwiftUI avec cette application cliquez sur show pour afficher l'animation et hide pour cacher et sur Next Transition pour passer à la transition suivante. cette pop-up n'est affiché que 3 fois au lancement de l'application après son installation"
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.white)

                Button {
                    withAnimation {
                        isPopupShown = false
                    }
                } label: {
                    Text("Continuer")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.cyan)
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(16)
        }
    }

    // MARK: - Check and Show Popup
    private func checkAndShowPopup() {
        let launchCountKey = "launchCount"
        let currentCount = UserDefaults.standard.integer(forKey: launchCountKey)
        print(currentCount)

        if currentCount < 3 {
            isPopupShown = true
            UserDefaults.standard.set(currentCount + 1, forKey: launchCountKey)
        }
    }
}

#Preview {
    ContentView()
}
