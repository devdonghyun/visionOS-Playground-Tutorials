//
//  LabelView.swift
//  LabelMaker
//
//  Created by 안동현 on 5/12/26.
//

import SwiftUI

struct LabelView: View {
    @Binding var label: Label
    
    var body: some View {
        TextField("Type to enter Text", text: $label.text, axis: .vertical)
            .frame(width: 500, height: 500)
            .padding()
            .background(.blue, in: RoundedRectangle(cornerRadius: label.cornerRadius))
            .foregroundStyle(.black)
            .font(.system(size: 40, weight: .semibold))
            .multilineTextAlignment(.center)
    }
}

#Preview {
    @Previewable @State var label = Label()
    LabelView(label: $label)
}
