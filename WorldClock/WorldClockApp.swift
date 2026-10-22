//
//  WorldClockApp.swift
//  WorldClock
//
//  Created by Aditya on 10/22/26.
//

import SwiftUI

@main
struct WorldClockApp: App {
    var body: some Scene {
        DocumentGroup { document in
            ContentView(document: document)
        } makeDocument: { configuration, context in
            WorldClockDocument()
        }
    }
}
