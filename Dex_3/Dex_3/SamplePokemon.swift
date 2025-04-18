//
//  SamplePokemon.swift
//  Dex_3
//
//  Created by Joel Espinal on 1/10/24.
//

import Foundation
import CoreData

struct SamplePokemon {
    static let samplePokemon = {
        let context = PersistenceController.preview.container.viewContext
        
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let result = try! context.fetch(fetchRequest)

        return result.first!
    }()
}
