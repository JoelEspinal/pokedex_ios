//
//  PokemonViewModel.swift
//  Dex_3
//
//  Created by Joel Espinal on 30/9/24.
//

import Foundation


@MainActor
class PokemonViewModel: ObservableObject {
    enum Status {
        case notStarted
        case fetching
        case susses
        case faild(error: Error)
    }
    
    @Published private(set) var status = Status.notStarted
    
    private let controller: FetchController
    
    init(controller: FetchController) {
        self.controller = controller
        
        Task {
            await getPokemon()
        }
    }
    
    private func getPokemon() async {
        status = .fetching
     
        do {
            var pokedex = try await controller.fetchAllPokemon()
            
            pokedex.sort { $0.id < $1.id}
            
            for pokemon in pokedex {
                let newPokemon =  Pokemon(context: PersistenceController.shared.container.viewContext)
                
                newPokemon.id = Int16(pokemon.id)
                newPokemon.name = pokemon.name
                newPokemon.types = pokemon.types
                newPokemon.hp = Int16(pokemon.hp)
                newPokemon.attack = Int16(pokemon.attack)
                newPokemon.defense = ((pokemon.defese) != 0)
                newPokemon.specialAttack = Int16(pokemon.specialAtack)
                newPokemon.specialDefense = Int16(pokemon.specialDefense)
                newPokemon.speed = Int16(pokemon.speed)
                newPokemon.sprite = pokemon.sprite
                newPokemon.shiny = pokemon.shiny
                newPokemon.favorite = false
                
                try PersistenceController.shared.container.viewContext.save()
            }
            status = .susses
        } catch {
            status = .faild(error: error)
        }
        
        
    }
}
