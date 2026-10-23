//
//  ContentView.swift
//  WorldClock
//
//  Created by Aditya on 10/22/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "clock.badge.checkmark")
                .font(.system(size: 40))
                .foregroundColor(.accentColor)
            Text("World Clock Widget is Active")
                .font(.headline)
            Text("You can close this window. The widget will stay on your desktop.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(30)
        .frame(width: 300, height: 180)
    }
}

#Preview {
    ContentView()
}
