//
//  ContentView.swift
//  SuperHeroFinder
//
//  Created by Jimmy on 25/7/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @State var superheroName: String = ""
    @State var heroesData: ApiNetwork.HeroesData? = nil
    @State var isLoading: Bool = false
    
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
                isLoading = true
                Task {
                    do {
                        heroesData = try await ApiNetwork().getSuperHeroByNamme(name: superheroName)
                    } catch {
                        print("Error")
                    }
                    isLoading = false
                }
            }
            if (isLoading) {
                ProgressView().padding(.top, 8).tint(.white)
            }
            ResultList(heroesData: $heroesData)
            Spacer()
        }
        .padding()
        .background(.backgroundApp)
    }
}

struct ResultList: View {
    @Binding var heroesData: ApiNetwork.HeroesData?
    var body: some View {
        NavigationStack {
            List(heroesData?.results ?? []) { superHero in
                ZStack {
                    SuperHeroItem(superHero: superHero)
                    NavigationLink(destination: {  }) {
                        EmptyView()
                    }
                    .opacity(0)
                }
                .listRowBackground(Color.backgroundApp)
            }
            .listStyle(.plain)
        }
    }
}

struct SuperHeroItem: View {
    let superHero: ApiNetwork.SuperHeroData
    var body: some View {
        ZStack {
            WebImage(url: URL(string: superHero.image.url))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(height: 200)
            VStack {
                Spacer()
                Text(superHero.name)
                    .font(.title2)
                    .bold()
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.white.opacity(0.5))
            }
        }
        .frame(height: 200)
        .cornerRadius(16)
    }
}

#Preview {
    ContentView()
}
