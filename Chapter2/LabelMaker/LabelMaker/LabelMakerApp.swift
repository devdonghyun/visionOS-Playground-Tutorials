//
//  LabelMakerApp.swift
//  LabelMaker
//
//  Created by 안동현 on 5/12/26.
//

import SwiftUI

@main
struct LabelMakerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizability(.contentSize)
        
        WindowGroup(for: Label.self) { $label in
            LabelView(label: $label)
                .disabled(true)
        } defaultValue: {
            Label(text: "", cornerRadius: 20.0 )
        }
        .windowResizability(.contentSize)
        .windowStyle(.plain)
    }
}
