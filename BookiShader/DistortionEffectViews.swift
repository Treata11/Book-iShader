/*
 DistortionEffectViews.swift
 BookiShader

 Created by Treata Norouzi on 4/4/24.
 
 Abstract:
 
*/

import DistortionEffect
import SwiftUI

// MARK: - Wave

struct Wave: View {
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)

            subjectView
                .wave(time: elapsedTime)
        }
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(systemName: "visionpro")
            .font(.system(size: 250))
            .background(.background)
            .drawingGroup()
    }
}

#Preview("Wave") { Wave() }

// MARK: - Relative Wave

struct RelativeWave: View {
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)

            subjectView
                .visualEffect { content, proxy in
                    content
                        .relativeWave(size: proxy.size, time: elapsedTime)
                }
        }
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("RelativeWave") { RelativeWave() }

// MARK: - Water

struct Water: View {
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)

            subjectView
                .visualEffect { content, proxy in
                    content
                        .water(size: proxy.size, time: elapsedTime)
                }
        }
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(systemName: "visionpro")
            .font(.system(size: 250))
            .padding()
            .background(.background)
            .drawingGroup()
    }
}

#Preview("Water") { Water() }

// MARK: - Sine Distortion

struct SineDistortion: View {
    @State private var startTime = Date.now
    @State var intensity: Float = 2

    var body: some View {
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)

            VStack {
                subjectView
                    .visualEffect { content, proxy in
                        content
                            .sineDistortion(size: proxy.size, time: elapsedTime, intensity: intensity)
                    }
                
                Slider(value: $intensity, in: 0.5...10)
                    .padding()
            }
        }
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(systemName: "visionpro")
            .font(.system(size: 250))
            .padding()
            .background(.background)
            .drawingGroup()
    }
}

#Preview("Sine Distortion") { SineDistortion() }

// MARK: - Worley Displacement

struct WorleyDisplacement: View {
    @State var paused = false
    
    @State private var startTime = Date.now
    @State var displace: Float = 0.125

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.05, paused: paused)) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)
        
            VStack {
                subjectView
                    .visualEffect { content, proxy in
                        content
                            .worleyDisplacement(size: proxy.size, time: elapsedTime, displace: displace)
                    }
                
                Slider(value: $displace, in: -0.5...0.5).padding()
            }
        }
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("Worley Displacement") { WorleyDisplacement() }

// MARK: - Barrel Distortion

struct BarrelDistortion: View {
    @State var paused = false

    var body: some View {
        subjectView
            .visualEffect { content, proxy in
                content
                    .barrelDistortion(size: proxy.size)
            }
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("Barrel Distortion") { BarrelDistortion() }

// MARK: - Pinch

struct Pinch: View {
    @State var paused = false
    
    @State var factor: Float = 0

    var body: some View {
        VStack {
            subjectView
                .visualEffect { content, proxy in
                    content
                        .pinch(size: proxy.size, factor: factor)
                }
            
            Slider(value: $factor, in: -0.5...0.5).padding()
        }
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("Pinch") { Pinch() }
