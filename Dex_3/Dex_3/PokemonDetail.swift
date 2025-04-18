//
//  PokemonDetail.swift
//  Dex_3
//
//  Created by Joel Espinal on 1/10/24.
//

import SwiftUI
import CoreData

struct PokemonDetail: View {
    
    @EnvironmentObject var pokemon: Pokemon
    
    var body: some View {
        ScrollView{
            ZStack {
                Image("normalgrasselectricpoisonfair")
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black, radius: 6)
                AsyncImage(url: pokemon.sprite) { image in
                    image.resizable()
                        .scaledToFit()
                        .padding(.top, 50)
                } placeholder: {
                   ProgressView()
                }
            }
            
            HStack {
                ForEach(pokemon.types!, id: \.self) { type in
                    Text(type.capitalized)
                        .font(.title2)
                        .shadow(color: .white, radius: 1)
                        .padding([.top, .bottom], 7)
                        .padding([.leading, .trailing])
                        .background(Color(type.capitalized))
                        .cornerRadius(50)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    struct PokemonDetail_Preview: PreviewProvider {
        

        static var previews: some View {
//            let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
            
            PokemonDetail().environmentObject(SamplePokemon.samplePokemon)
        }
    }
}


