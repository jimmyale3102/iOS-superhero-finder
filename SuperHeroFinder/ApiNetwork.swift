//
//  ApiNetwork.swift
//  SuperHeroFinder
//
//  Created by Jimmy on 25/7/2024.
//

import Foundation

class ApiNetwork {
    
    let baseURL = "https://superheroapi.com/api/71cbc154ee27370f93f9f422e79aaa9c/"
    let pathSearch = "search/"
    
    struct HeroesData: Codable {
        let response: String
        let results: [SuperHeroData]
    }
    
    struct SuperHeroData: Codable, Identifiable {
        let id: String
        let name: String
        let image: HeroImage
        let powerstats: Powerstats
        let biography: Biography
    }
    
    struct HeroImage: Codable {
        let url: String
    }
    
    struct Powerstats: Codable {
        let intelligence: String
        let strength: String
        let speed: String
        let durability: String
        let power: String
        let combat: String
    }
    
    struct Biography: Codable {
        let fullName: String
        let aliases: [String]
        let publisher: String
        let alignment: String
        
        enum CodingKeys: String, CodingKey {
            case fullName = "full-name"
            case aliases = "aliases"
            case publisher = "publisher"
            case alignment = "alignment"
        }
    }
    
    func getSuperHeroByNamme(name: String) async throws -> HeroesData {
        let apiUrl = baseURL + pathSearch + name
        let url = URL(string: apiUrl)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let heroesData = try JSONDecoder().decode(HeroesData.self, from: data)
        return heroesData
    }
    
    func getHeroById(id: String) async throws -> SuperHeroData {
        let apiUrl = baseURL + id
        let url = URL(string: apiUrl)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let superHeroData = try JSONDecoder().decode(SuperHeroData.self, from: data)
        return superHeroData
    }
}
