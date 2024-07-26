//
//  HeroDetail.swift
//  SuperHeroFinder
//
//  Created by Jimmy on 25/7/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct HeroDetail: View {
    @State var isLoading: Bool = true
    @State var superHeroData: ApiNetwork.SuperHeroData? = nil
    let id: String
    
    var body: some View {
        VStack {
            if (isLoading) {
                ProgressView().tint(.white)
            } else if let superHeroData = superHeroData {
                SuperHeroDetails(superHeroData: superHeroData)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundApp)
        .onAppear {
            isLoading = true
            Task {
                do {
                    superHeroData = try await ApiNetwork().getHeroById(id: id)
                } catch {
                    superHeroData = nil
                }
                isLoading = false
            }
        }
    }
}

struct SuperHeroDetails: View {
    let superHeroData: ApiNetwork.SuperHeroData
    var body: some View {
        VStack {
            WebImage(url: URL(string: superHeroData.image.url))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(height: 250)
                .clipped()
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 32,
                        bottomTrailingRadius: 32,
                        topTrailingRadius: 0
                    )
                )
            Text(superHeroData.name)
                .font(.title)
                .bold()
                .foregroundStyle(.white)
            ForEach(superHeroData.biography.aliases, id: \.self) { alias in
                Text(alias)
                    .foregroundStyle(.gray)
                    .italic()
            }
            Spacer()
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(.backgroundApp)
    }
}

#Preview {
    HeroDetail(id: "5")
}
