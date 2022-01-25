//
//  ActivityDataApp.swift
//  ActivityData
//
//  Created by Anthony Olds on 1/24/22.
//

import SwiftUI

@main
struct ActivityDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ModelData())
        }
    }
}
