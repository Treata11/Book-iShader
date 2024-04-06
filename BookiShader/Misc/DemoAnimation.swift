/*
 DemoAnimation.swift
 Book iShader

 Created by Treata Norouzi on 4/6/24.
 
 Abstract:
 A hard-coded, unusabel View, constructed only for demonstration purposes ...
*/

import SwiftUI

// MARK: - The animation

/*
struct MovingRectanglesView: View {
    @State private var offsetX: CGFloat = 100
    
    let numberOfRectangles = 5
    let rectBound: CGFloat = 100
    let spacing: CGFloat = 5
    
    var colors: [Color] = [.red, .blue, .blue, .blue, .yellow]
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(0..<numberOfRectangles, id: \.self) { index in
                    Rectangle()
                        .fill(colors[index])
                        .frame(width: rectBound, height: rectBound)
                        .offset(x: CGFloat(index) * (rectBound + spacing) + offsetX)
                }
            }
            .animation(.linear(duration: 5), value: true) // Adjust the duration for the speed of animation
            .onAppear {
                withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: false)) {
                    offsetX = -CGFloat(numberOfRectangles+1) * (rectBound + spacing)
                }
            }
        }
    }
}

#Preview("The animation") {
    MovingRectanglesView()
}
*/
 
// Second Approach

import ShaderArt

struct GridLoopOfShaders: View {
    @State private var startTime: Date = .now
    
    @State private var loopActivated = false
    
    let waitTime: Double = 10
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 1/48)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            var run: TimeInterval {
                loopActivated ? elapsedTime : 1
            }
            
            VStack(spacing: 0) {
                LazyHGrid(rows: [GridItem()]) {
                    firstHGrid(elapsedTime: elapsedTime)
                    firstHGrid(elapsedTime: elapsedTime)
                }
                .offset(x: -12.5 * run)
                
                LazyHGrid(rows: [GridItem()]) {
                    secondHGrid(elapsedTime: elapsedTime)
                    secondHGrid(elapsedTime: elapsedTime)
                }
                .offset(x: 12.5 * run + 31.5)
                
                LazyHGrid(rows: [GridItem()]) {
                    thirdHGrid(elapsedTime: elapsedTime)
                    thirdHGrid(elapsedTime: elapsedTime)
                }
                .offset(x: -12.5 * run + 6.25)
            }
            .background {
                GradientFlow(colors: [Color(90, 85, 100), Color(157, 162, 203), Color(50, 67, 100), Color(54, 50, 66)], time: elapsedTime - waitTime)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + waitTime) {
                self.loopActivated = true
            }
        }
    }
    
    func firstHGrid(elapsedTime: TimeInterval) -> some View {
        Group {
            BlackHoleDawn(time: elapsedTime*0.2)
                .modifiers()
            
            TMGyroids(time: elapsedTime*1.2)
                .modifiers()
            
            ExplosionCloud(time: elapsedTime*1.3)
                .modifiers()
            
            BlueVoid(time: elapsedTime, location: .zero)
                .modifiers()
            
            Singularity(time: elapsedTime*1.5)
                .modifiers()
        }
    }
    
    func secondHGrid(elapsedTime: TimeInterval) -> some View {
        Group {
            SineWaves(time: elapsedTime)
                .modifiers()
            
            Clouds(time: elapsedTime*1.3)
                .modifiers()
            
            FBMLightning(time: elapsedTime)
                .modifiers()
            
            ModFan(time: elapsedTime*0.5)
                .modifiers()
            
            WetNeuralNetwork(time: elapsedTime*1.5, location: .zero)
                .modifiers()
        }
    }
    
    func thirdHGrid(elapsedTime: TimeInterval) -> some View {
        Group {
            BeamDroplet(time: elapsedTime)
                .modifiers()
            
            StarField(time: elapsedTime*0.3)
                .modifiers()
            
            NeonRug(time: elapsedTime)
                .modifiers()
            
            CrystalCaustic(time: elapsedTime*0.2)
                .modifiers()
            
            Portal(time: elapsedTime)
                .modifiers()
        }
    }
}

fileprivate extension View {
    func modifiers() -> some View {
        return self
            .frame(width: 116, height: 116)
            .clipShape(.rect(cornerRadius: 16.8, style: .continuous))
    }
}

#Preview("GridLoopOfShaders") {
    GridLoopOfShaders()
        .frame(width: 600, height: 375)
}

#Preview("") {
    GradientFlow(time: 1 * 0.5)
}
