//
//  ApiNetwork.swift
//  SuperHeroFinder
//
//  Created by Jimmy on 25/7/2024.
//

import Foundation

class ApiNetwork {
    
    struct HeroesData: Codable {
        let response: String
        let results: [SuperHeroData]
    }
    
    struct SuperHeroData: Codable {
        let id: String
        let name: String
    }
    
    func getSuperHeroByNamme(name: String) async throws -> HeroesData {
        let url = URL(string: "https://superheroapi.com/api/71cbc154ee27370f93f9f422e79aaa9c/search/\(name)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let heroesData = try JSONDecoder().decode(HeroesData.self, from: data)
        return heroesData
    }
}
