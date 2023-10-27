//
//  math.swift
//  test
//
//  Created by 하승민 on 10/23/23.
//

import Foundation
import simd

class math {
    
    func getDist(pos1: CGPoint, pos2: CGPoint = CGPoint(x: 0, y: 0)) -> Double {
        return sqrt(pow((pos1.y - pos2.y), 2) + pow((pos1.x - pos2.x), 2))
    }
    
    func getDist(x: Double, y: Double, z: Double) -> Double {
        return sqrt(x * x + y * y + z * z)
    }
    
    func getDist(pos: [Double]) -> Double {
        let (x, y, z) = (pos[0], pos[1], pos[2])
        
        return sqrt(x * x + y * y + z * z)
    }
    func getAngle(pre: CGPoint, cur: CGPoint) -> Double {
        
        let a = getDist(pos1: pre)
        let b = getDist(pos1: cur, pos2: pre)
        let c = getDist(pos1: cur)
        
        //print(a, b, c)
        let angle = (pow(a, 2) + pow(b, 2) - pow(c, 2)) / ( 2 * a * b )
        
        return angle
    }
    
    func getVector(pre: CGPoint, cur: CGPoint) -> CGVector {
        return CGVector(dx: cur.x - pre.x, dy: cur.y - pre.y).nomalize()
    }
    
    func stdVector(x: Double, y: Double, z: Double) -> [Double] {
        
        let len = getDist(x: x, y: y, z: z)
        
        if len == 0 {
            return [0, 0, 0]
            
        } else {
            return [x / len, y / len, z / len]
            
        }
    }
}
