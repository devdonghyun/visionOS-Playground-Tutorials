//
//  ContentView.swift
//  LabelMaker
//
//  Created by 안동현 on 5/12/26.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var label = Label()
    
    var body: some View {
        LabelView(label: $label)
            .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
