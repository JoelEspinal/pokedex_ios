//
//  ContentView.swift
//  Dex_3
//
//  Created by Joel Espinal on 23/9/24.
//

import SwiftUI
import CoreData
import Foundation


struct ContentView: View {
    @State private var hasAppeared = false
    @State var pokemons = [TempPokemon]()
    
    //    @EnvironmentObject var pokemon: Pokemon
    
    //    //@Environment(\.managedObjectContext) private var viewContext
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
    //        animation: .default)
    //    
    
    
    //    public var pokedex: FetchedResults<Pokemon>
    
    
    
    
    
    //    var a = [TempPokemon]()
    
    //    func viewDidLoad() {
    //     var a =  catchedPokemons
    //        
    //    }
    
    
    
    
    //     let catchedPokemons = { () -> [TempPokemon] in
    //         var pokemons = [TempPokemon]()
    //        Task {
    //            ContentView.agua = try await FetchController().fetchAllPokemon()
    //            let recivingPokemons = try await FetchController().fetchAllPokemon()
    //               pokemons =  recivingPokemons
    //            return pokemons
    //        }
    //      
    //         return pokemons
    //    }()
    //    
    
    
    var body: some View {
        NavigationStack {
            List(pokemons, id: \.id) { pokemon in
                
                NavigationLink(value: pokemon.name) {
                    
                    AsyncImage(url: pokemon.sprite) { image in
                        image.resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    
                    Text(pokemon.name.capitalized)
                }
                
            }
            
            .navigationTitle("Pokedex")
            .navigationDestination(for: Pokemon.self, destination: { pokemon in
                AsyncImage(url: pokemon.sprite) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                }
            }
        }
        .onAppear() {
            if pokemons.isEmpty && !hasAppeared {
                Task {
                    do {
                        let catchPokemon = try await FetchController().fetchAllPokemon()
                        pokemons = catchPokemon
                        DispatchQueue.main.async {
                            pokemons = catchPokemon  
                        }
                    } catch {
                        print("Error is ContentView")
                    }
                }
            }
        }
        
        
        
        let itemFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .medium
            return formatter
        }()
    
    }
        //func getPokemons() {
        //
        //    DispatchQueue.main.async {
        //       var  catchPokemon = [TempPokemon]()
        //        Task {
        //            do {
        //                catchPokemon = try await FetchController().fetchAllPokemon()
        //
        //                DispatchQueue.main.async {
        //                    pokemons = catchPokemon
        //                }
        //            } catch {
        //                print(error)
        //            }
        //        }
        //    }
        //}
        
        //    Task {
        //        ContentView.agua = try await FetchController().fetchAllPokemon()
        //        let recivingPokemons = try await FetchController().fetchAllPokemon()
        //           pokemons =  recivingPokemons
        //        pokemons =  pokemons
        //    }
        //
        //     return pokemons
        
        
        
        
        //struct Pokemon_Preview: PreviewProvider {
        //    let poke = PersistenceController.shared
        //    static var previews: some View {
        //
        //        PokemonDetail().environmentObject(SamplePokemon.samplePokemon)
        //    }
        //}
        
        
//        struct ContentView_Preview: PreviewProvider {
           // static var previews: some View {
                // ContentView() //.environmentObject(PersistenceController.shared)
                // ContentView()
                
           // }
//        }
    }

