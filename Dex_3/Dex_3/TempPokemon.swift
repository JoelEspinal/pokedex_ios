//
//  TempPokemon.swift
//  Dex_3
//
//  Created by Joel Espinal on 24/9/24.
//

import Foundation

struct TempPokemon:  Codable {
    
    let id: Int
    let name: String
    let types: [String]
    var hp = 0
    var attack = 0
    var defese = 0
    var specialAtack = 0
    var specialDefense = 0
    var speed = 0
    var sprite: URL?
    var shiny: URL?
    
    enum PokemonKeys: String, CodingKey {
        case id
        case name
        case types
        case stats
        case sprites
        
        enum TypeDictionarykeys: String, CodingKey {
            case type
            
            enum TypeKeys: String, CodingKey {
                case name
            }
        }
        
        enum StatDictioraryKey: String, CodingKey {
            case value = "base_stat"
            case stat
            
            enum StatKey: String, CodingKey {
                case name
            }
        }
        
        enum SpriteKeys: String, CodingKey {
            case sprite = "front_default"
            case shiny = "front_shiny"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        var decoderTypes: [String] = []
        var typesConteiner = try container.nestedUnkeyedContainer(forKey: .types)
        while !typesConteiner.isAtEnd {
            let typesDictionaryContainer = try typesConteiner.nestedContainer(keyedBy: PokemonKeys.TypeDictionarykeys.self)
            let typeContainer = try typesDictionaryContainer
                .nestedContainer(keyedBy: PokemonKeys.TypeDictionarykeys.TypeKeys.self, forKey: .type)
            
            let type = try typeContainer.decode(String.self, forKey: .name)
            decoderTypes.append(type)
        }
        
        types = decoderTypes
        
        var statsContainer = try container.nestedUnkeyedContainer(forKey: .stats)
        while !statsContainer.isAtEnd {
            let statsDictionaryContainer = try statsContainer.nestedContainer(keyedBy: PokemonKeys.StatDictioraryKey.self)
            let statContainer = try statsDictionaryContainer.nestedContainer(keyedBy: PokemonKeys.StatDictioraryKey.StatKey.self, forKey: .stat)
            
            switch try statContainer.decode(String.self, forKey: .name) {
            case "hp":
                hp = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "attack":
                attack = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "defense":
                defese = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "special-attack":
                specialAtack = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "special-defense":
                specialDefense = try statsDictionaryContainer.decode(Int.self, forKey: .value)
            case "speed":
                speed = try statsDictionaryContainer.decode(Int.self, forKey: .value)
           
            default:
                print("......")
            }
            
            let spriteContainer = try container.nestedContainer(keyedBy: PokemonKeys.SpriteKeys.self, forKey: .sprites)
            sprite = try spriteContainer.decode(URL.self, forKey: .sprite)
            shiny = try spriteContainer.decode(URL.self, forKey: .shiny)
        }
    }
}
    
