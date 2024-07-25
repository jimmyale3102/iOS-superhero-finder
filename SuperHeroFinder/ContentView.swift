//
//  ContentView.swift
//  SuperHeroFinder
//
//  Created by Jimmy on 25/7/2024.
//

import SwiftUI

struct ContentView: View {
    @State var superheroName: String = ""
    var body: some View {
        VStack {
            TextField(
                "",
                text: $superheroName,
                prompt: Text("Superhero name")
                    .font(.title2)
                    .foregroundColor(.tertiaryApp)
            )
            .font(.title2)
            .foregroundColor(.white)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.secondaryApp, lineWidth: 2)
            )
            .autocorrectionDisabled()
            .onSubmit {
                Task {
                    do {
                        let heroesData = try await ApiNetwork().getSuperHeroByNamme(name: superheroName)
                        print(heroesData)
                    } catch {
                        print("Error")
                    }
                }
            }
            Spacer()
        }
        .padding()
        .background(.backgroundApp)
    }
}

#Preview {
    ContentView()
}
