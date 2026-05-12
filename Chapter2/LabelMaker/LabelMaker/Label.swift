//
//  Label.swift
//  LabelMaker
//
//  Created by 안동현 on 5/12/26.
//

import Foundation

struct Label: Hashable, Codable {
    var id = UUID()
    var text = ""
    var cornerRadius = 20.0
}
