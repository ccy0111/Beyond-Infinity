//
//  ContentView.swift
//  test
//
//  Created by 하승민 on 10/23/23.
//

import SwiftUI



struct ContentView: View {
    
    //static let fps = 0.01
    let timer = Timer.publish(every: Const.fps, on: .main, in: .common).autoconnect()
    
    @ObservedObject var haHa = haha()
    
    @State private var prePos: CGPoint = CGPoint(x: 0.0, y: 0.0)
    @State private var start: Bool = true
    
    @State private var topArea: CGFloat = 0.0
    @State private var bottomArea: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { proxy in
            
            VStack {
                Circle()
                    .fill(.brown)
                    .frame(width: haHa.frame.width, height: haHa.frame.height)
                    .position(x: haHa.pos.x, y: haHa.pos.y)
                    .gesture(
                        DragGesture()
                            .onChanged() { value in
                                
                                if start {
                                    prePos = value.startLocation
                                    haHa.movable.toggle()
                                    start.toggle()
                                }
                                
                                haHa.pos = value.location
                                
                                let vector = math().getVector(pre: prePos, cur: haHa.pos)
                                
                                haHa.vector = vector
                                haHa.speed = math().getDist(pos1: haHa.pos, pos2: prePos)
                                prePos = haHa.pos
                            }
                            .onEnded() { value in
                                haHa.movable.toggle()
                                start.toggle()
                            }
                    )
            }
            .onAppear(perform: {
                topArea = proxy.safeAreaInsets.top
                bottomArea = proxy.safeAreaInsets.bottom
            })
            .onChange(of: haHa.pos) { _, _ in
               
            }
        }
        .onReceive(timer) { _ in
            haHa.move()
            haHa.bounce(minY: topArea, maxY: Const.deviceHeight - bottomArea)
        }
       
    }
}

#Preview {
    ContentView()
}
