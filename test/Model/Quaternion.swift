//
//  Quaternion.swift
//  test
//
//  Created by 하승민 on 10/26/23.
//

import Foundation

class Quaternion {
    
    public var x: Double
    public var y: Double
    public var z: Double
    public var w: Double
    
    // 회전 대상체를 생성할 때 사용
    init(x: Double, y: Double, z: Double, w: Double) {
        
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    // 회전 축 생성할 때 사용
    init(vector: [Double], angle: Double) {
        let s = sin(angle / 2)
        self.x = vector[0] * s
        self.y = vector[1] * s
        self.z = vector[2] * s
        
        self.w = cos(angle / 2)
    }
    
    // 쿼터니언의 역원 구하기
    func inverse() -> Quaternion {
        let norm = w * w + x * x + y * y + z * z
        return Quaternion(x: -x / norm, y: -y / norm, z: -z / norm, w: w / norm)
    }
    
    func getPos() -> [Double] {
        
        return [self.x, self.y, self.z]
    }
    
    func rotation(point: [Double]) -> [Double] {
        
        // 회전 대상
        let subQuat = Quaternion(x: point[0], y: point[1], z: point[2], w: 0)
        
        let inversedQuat = self.inverse()
    	
        let rotatedQuat = self * (subQuat * inversedQuat)
        
        return rotatedQuat.getPos()
    }
}

extension Quaternion {
    static func *(q1: Quaternion, q2: Quaternion) -> Quaternion {
        
        let x = (q1.w * q2.x) + (q1.x * q2.w) + (q1.y * q2.z) - (q1.z * q2.y)
        let y = (q1.w * q2.y) - (q1.x * q2.z) + (q1.y * q2.w) + (q1.z * q2.x)
        let z = (q1.w * q2.z) + (q1.x * q2.y) - (q1.y * q2.x) + (q1.z * q2.w)
        let w = (q1.w * q2.w) - (q1.x * q2.x) - (q1.y * q2.y) - (q1.z * q2.z)
        
        return Quaternion(x: x, y: y, z: z, w: w)
    }
}
