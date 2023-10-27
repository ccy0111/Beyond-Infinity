//
//  SpaceTravel.swift
//  test
//
//  Created by 하승민 on 10/24/23.
//

import SwiftUI

struct SpaceTravel: View {
    
    
   
    @ObservedObject var starManagerObj = starManager()
    
    // scalarMatrix : vector that user is going foward
    @State var scalarMatrix: [Double] = [0, 0, 3]
    // axis : the center of rotate
    @State var axis: Quaternion = Quaternion(vector: math().stdVector(x: 0, y: 0, z: 1), angle: Const.rpf * Const.fps * 2)
    
    
    // Const.fps => 1.0 / 60.0 (60 프레임이라고 가정)
    let timer = Timer.publish(every: Const.fps, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            
            ForEach(starManagerObj.stars){ star in
                if !star.outOfBoundary() {
                    Circle()
                        .frame(width: star.getFrame(), height: star.getFrame())
                        .foregroundStyle(star.color)
                        .position(star.getPoint())
                }
            }
    
        }
        .ignoresSafeArea()
        .background(.black)
        .onReceive(timer, perform: { _ in
            starManagerObj.update(scalar: scalarMatrix, axis: axis)
        })
    }
}

#Preview {
    SpaceTravel()
}
