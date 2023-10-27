//
//  star.swift
//  test
//
//  Created by 하승민 on 10/24/23.
//

import Foundation
import SwiftUI

// 별 하나의 정보를 담고 있는 클래스
class star: ObservableObject, Identifiable{
    var id: UUID = UUID()
    var color: Color
    
    @Published var position: [Double]
    
    // 별의 반지름
    var radious: Double
    init(radious: Double = 40, position: [Double] = [Const.centerX, Const.centerY, 100], color: Color = .white) {
        self.radious = radious
        self.position = position
        self.color = color
    }
    
    func move(scalar: [Double], axis: Quaternion) {
        position = axis.rotation(point: position)
        //print(position)
        for i in 0..<3 {
            position[i] -= scalar[i]
        }
    }
}

extension star {
    
    // distance between star and center (0, 0, 0)
    func getDist() -> Double {
        let distance = math().getDist(x: self.position[0], y: self.position[1], z: self.position[2])
        return distance
    }
    
    // Returns the actual size to be seen on the screen
    func getRadius() -> CGFloat {
        if self.position[2] == 0 {
            return self.radious * 2
        }
        let radious = self.radious * 20 / self.position[2]
        return  radious
    }
    
    // 실제 화면에 보이는 지름 값을 리턴함
    func getDiameter() -> CGFloat {
        let rad = self.getRadius()
        
        // 최소 크기 보정
        return rad * 2 > 1 ? rad * 2 : 1
    }
    
    func getFrame() -> CGFloat {
        return getDiameter()
    }
    
    // return 2D point
    func getPoint() -> CGPoint {
        
        let realX = self.position[0] - Const.centerX
        let realY = self.position[1] - Const.centerY

        // Out of Boundary 함수에서 z값이 0일때를 미리 판별하기 때문에, 그냥 나누기
        let x = realX * 300 / self.position[2]
        let y = realY * 300 / self.position[2]
        
        // 실제 계산은 0, 0을 기점으로 하기 !!! 조심
        return CGPoint(x: x + Const.centerX, y: y + Const.centerY)
    }
    
    // 화면에 들어와 있는지 확인함
    func outOfBoundary() -> Bool {
        let star = self
        
        // 확실히 밖으로 나간다면
        if star.position[2] <= 0.0 {
            return true
        }
        
        if star.getPoint().x + star.getRadius() / 2 > Const.deviceWidth ||
            star.getPoint().x - star.getRadius() / 2 < 0 {
            return true
        }
        
        if star.getPoint().y + star.getRadius() / 2 > Const.deviceHeight ||
            star.getPoint().y - star.getRadius() / 2 < 0 {
            return true
        }
        
        return false
    }
    
    // 별이 중심 좌표로부터 너무 멀어지면 소멸시켜주기
    func outOfRange() -> Bool {
        let dist = self.getDist()
        
        if dist >= Const.boundary {
            return true
        }
        
        return false
    }
}

class starManager: ObservableObject {
    @Published var stars: [star] = [star(position: [1000, 1000, 200])]

    // makes star's Pos that could be in boundary
    func makePos() -> [Double] {
        let x = Double.random(in: -1...1)
        let y = Double.random(in: -1...1)
        let z = Double.random(in: -1...1)
        
        var pos = math().stdVector(x: x, y: y, z: z)
        let dist = Double.random(in: 1000..<Const.boundary)
        
        for i in 0..<3 {
            pos[i] *= dist
        }
        
        return pos
    }
    
    // remove all stars that is Out Of Boundary
    func remove() {
        stars.removeAll() { star in
            star.outOfBoundary()
        }
    }
    
    func makeStar() {
        
        let posiotion: [Double] = makePos()
        let radius = Double.random(in: 40...200)
        
        let r = Double.random(in: 200..<255)
        let g = Double.random(in: 200..<255)
        let b = Double.random(in: 200..<255)
        
        let color = Color.rgb(r,g,b)
        let newStar = star(radious: radius, position: posiotion, color: color)
        
        stars.append(newStar)
    }
    
    func update(scalar: [Double], axis: Quaternion) {
        var trash: [star] = []
        
        for star in stars {
            
            star.move(scalar: scalar, axis: axis)
            if star.outOfRange() {
                trash.append(star)
            }
        }
        
        stars.removeAll { star in
            trash.contains { $0.id == star.id }
        }
    
        while(stars.count <= 4000) {
            makeStar()
        }
    }
    
}
