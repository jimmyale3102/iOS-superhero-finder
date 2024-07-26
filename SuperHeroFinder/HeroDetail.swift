//
//  HeroDetail.swift
//  SuperHeroFinder
//
//  Created by Jimmy on 25/7/2024.
//

import SwiftUI
import SDWebImageSwiftUI
import Charts

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
            SuperHeroStats(stats: superHeroData.powerstats)
            Spacer()
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(.backgroundApp)
    }
}

struct SuperHeroStats: View {
    let stats: ApiNetwork.Powerstats
    var body: some View {
        VStack {
            Chart {
                SectorMark(
                    angle: .value("Count", Int(stats.combat) ?? 0),
                    innerRadius: .ratio(0.7),
                    angularInset: 2
                )
                .cornerRadius(8)
                .foregroundStyle(by: .value("Category", "Combat"))
                SectorMark(
                    angle: .value("Count", Int(stats.durability) ?? 0),
                    innerRadius: .ratio(0.7),
                    angularInset: 2
                )
                .cornerRadius(8)
                .foregroundStyle(by: .value("Category", "Durability"))
                SectorMark(
                    angle: .value("Count", Int(stats.intelligence) ?? 0),
                    innerRadius: .ratio(0.7),
                    angularInset: 2
                )
                .cornerRadius(8)
                .foregroundStyle(by: .value("Category", "Intelligence"))
                SectorMark(
                    angle: .value("Count", Int(stats.power) ?? 0),
                    innerRadius: .ratio(0.7),
                    angularInset: 2
                )
                .cornerRadius(8)
                .foregroundStyle(by: .value("Category", "Power"))
                SectorMark(
                    angle: .value("Count", Int(stats.speed) ?? 0),
                    innerRadius: .ratio(0.7),
                    angularInset: 2
                )
                .cornerRadius(8)
                .foregroundStyle(by: .value("Category", "Speed"))
                SectorMark(
                    angle: .value("Count", Int(stats.strength) ?? 0),
                    innerRadius: .ratio(0.7),
                    angularInset: 2
                )
                .cornerRadius(8)
                .foregroundStyle(by: .value("Category", "Strength"))
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: 350)
        .background(.white)
        .cornerRadius(25)
        .padding()
    }
}

#Preview {
    HeroDetail(id: "3")
}
