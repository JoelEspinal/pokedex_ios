//
//  Dex_3App.swift
//  Dex_3
//
//  Created by Joel Espinal on 23/9/24.
//

import SwiftUI

@main
struct Dex_3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //ContentView()
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
       }
    }
}
