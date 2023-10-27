//
//  Extension.swift
//  test
//
//  Created by 하승민 on 10/23/23.
//

import Foundation
import SwiftUI

extension CGVector {
    func nomalize() -> CGVector {
        let length = sqrt(self.dy * self.dy + self.dx * self.dx)
        let ndx = self.dx / length
        let ndy = self.dy / length
        
        return CGVector(dx: ndx , dy: ndy)
    }
}

extension CGPoint {
    func getDist(pos: CGPoint) -> Double {
        return sqrt((pow(self.x - pos.x, 2) + pow(self.y - pos.y, 2)))
    }
}

extension Color {
    static let rgb = { (_r: Double, _g: Double, _b: Double) -> Color in
        return Color(red: _r / 255.0, green: _g / 255.0, blue: _b / 255.0)
    }
}
