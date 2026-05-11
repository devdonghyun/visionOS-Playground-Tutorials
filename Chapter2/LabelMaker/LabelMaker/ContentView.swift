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
            .ornament(attachmentAnchor: .scene(.bottom)) {
                HStack(spacing: 30) {
                    Slider(value: $label.cornerRadius, in: 0...100)
                        .frame(width: 100)
                }
                .padding()
                .glassBackgroundEffect()
            }
            
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
