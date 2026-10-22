//
//  ContentView.swift
//  WorldClock
//
//  Created by Aditya on 10/22/26.
//

import SwiftUI

struct ContentView: View {
    @Bindable var document: WorldClockDocument
    @Environment(\.undoManager) private var undoManager

    var body: some View {
        TextEditor(text: $document.text)
            .onChange(of: document.text) { oldValue, _ in
                undoManager?.registerUndo(withTarget: document) { document in
                    document.text = oldValue
                }
            }
            .font(.system(size: 16, weight: .regular, design: .monospaced))
    }
}

#Preview {
    ContentView(document: WorldClockDocument())
}
