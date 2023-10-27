//
//  Const.swift
//  test
//
//  Created by 하승민 on 10/23/23.
//

import SwiftUI

struct Const {
    static let deviceWidth = UIScreen.main.bounds.width
    static let deviceHeight = UIScreen.main.bounds.height
    static let centerX = deviceWidth / 2
    static let centerY = deviceHeight / 2
    static let fps = 1.0 / 60.0
    static let dist = 3.0
    
    static let boundary = math().getDist(pos: [3000, 3000, 3000])
    
    // rotate per sec
    static let rpf = Const.fps * 2 * .pi
}

