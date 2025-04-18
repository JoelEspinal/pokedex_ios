//
//  FetchController.swift
//  Dex_3
//
//  Created by Joel Espinal on 29/9/24.
//

import Foundation

struct FetchController {
    enum NetworkError: Error {
        case badURL, BadResponse, badData
    }
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func fetchAllPokemon() async throws -> [TempPokemon] {
        var allPokemon: [TempPokemon] = []
        
        var fetchCompoonents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        fetchCompoonents?.queryItems = [URLQueryItem(name: "limit", value: "20")]
        
        guard let fetchURL = fetchCompoonents?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.BadResponse
        }
        
        guard let pokeDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any], let pokedex = pokeDictionary["results"] as? [[String: String]] else {
            throw NetworkError.badData
        }
        
        for pokemon in pokedex {
            if let url = pokemon["url"] {
                allPokemon.append(try await fetchPokemon(from: URL(string: url)!))
            }
            
            
        }
        
        return allPokemon
    }
    
    private func fetchPokemon(from url: URL) async throws -> TempPokemon {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.BadResponse
        }
        
        let temPokemon = try JSONDecoder().decode(TempPokemon.self, from: data)
        
        print("fetched Ppkemon: \(temPokemon.name) \(temPokemon.name)")
        
        return temPokemon
    }
}
