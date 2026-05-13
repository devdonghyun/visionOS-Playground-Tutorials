//
//  LabelView.swift
//  LabelMaker
//
//  Created by 안동현 on 5/12/26.
//

import SwiftUI

struct LabelView: View {
    @Environment(\.isEnabled) private var isEnabled
    @Binding var label: Label
    
    var body: some View {
        TextField("Type to enter Text", text: $label.text, axis: .vertical)
            .frame(width: 500, height: isEnabled ? 500 : nil)
            .padding(50)
            .background(label.selectedColor(), in: RoundedRectangle(cornerRadius: label.cornerRadius))
            .foregroundStyle(.black)
            .font(.system(size: 40, weight: .semibold))
            .multilineTextAlignment(.center)
    }
}

#Preview {
    @Previewable @State var label = Label()
    LabelView(label: $label)
        .disabled(true)
}
