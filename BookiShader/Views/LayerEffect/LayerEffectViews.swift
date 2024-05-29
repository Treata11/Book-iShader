/*
 LayerEffectViews.swift
 Book iShader

 Created by Treata Norouzi on 4/4/24.
 
 Abstract:
 
*/

import LayerEffect
import SwiftUI

let layerEffectViews = [
    AnyView(ColorPlanes()), AnyView(Emboss()),
    AnyView(Bubble()), AnyView(WarpingLoupe()),
    AnyView(VHS()), AnyView(Sobel()),
    AnyView(SoftThreshold()), AnyView(SineWave())
]

// MARK: - Color Planes

struct ColorPlanes: View {
    @State private var touchLocation = CGSize.zero

    var body: some View {
        image
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(.black)
            .drawingGroup()
            .colorPlanes(translation: touchLocation)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { touchLocation = $0.translation }
            )
    }
    
    var image: some View {
        Image(systemName: "visionpro")
            .font(.system(size: 250))
            .foregroundStyle(.white)
    }
}

#Preview("colorPlanes") { ColorPlanes() }

// MARK: - Emboss

struct Emboss: View {
    @State private var embossAmount = 0.0

    var body: some View {
        VStack {
            subjectView
                .layerEffect(
                    ShaderLibrary.emboss(
                        .float(embossAmount)
                    ),
                    maxSampleOffset: .zero
                )

            Slider(value: $embossAmount, in: 0...20)
                .padding()
        }
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("Emboss") { Emboss() }

// MARK: - Bubble

struct Bubble: View {
    @State private var touchLocation = CGPoint.zero

    var body: some View {
        subjectView
            .visualEffect { content, proxy in
                content
                    .bubble(size: proxy.size, location: touchLocation)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { touchLocation = $0.location }
            )
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("Bubble") { Bubble() }

// MARK: - Warping Loupe

struct WarpingLoupe: View {
    @State private var touchLocation = CGPoint.zero

    var body: some View {
        subjectView
            .visualEffect { content, proxy in
                content
                    .warpingLoupe(size: proxy.size, location: touchLocation)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { touchLocation = $0.location }
            )
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("WarpingLoupe") { WarpingLoupe() }

// MARK: - VHS

struct VHS: View {
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.03)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            subjectView
                .vhs(time: elapsedTime)
                .clipShape(.rect)
        }
        .ignoresSafeArea()
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("VHS") { VHS() }

// MARK: - Sobel

struct Sobel: View {
    var body: some View {
        subjectView
            .sobel()
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("Sobel") { Sobel() }

// MARK: - Soft Threshold

struct SoftThreshold: View {
    var body: some View {
        subjectView
            .softThreshold()
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("Soft Threshold") { SoftThreshold() }

// MARK: - Sine Wave

struct SineWave: View {
    @State private var startTime: Date = .now
    
    @State var intensity: Float = 10
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.025)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            VStack {
                subjectView
                    .sineWave(time: elapsedTime, intensity: intensity)
                
                Slider(value: $intensity, in: 2...50)
                    .padding()
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

#Preview("Sine Wave") { SineWave() }

