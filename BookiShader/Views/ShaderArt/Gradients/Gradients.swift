/*
 Gradients.swift
 Book iShader

 Created by Treata Norouzi on 4/7/24.
 
 Abstract:
 
*/

import ShaderArt
import SwiftUI

let gradientViews: [AnyView] = [
    AnyView(RotatingGradientView()), AnyView(ChromaGradientsView()),
    AnyView(FluidGradientView()), AnyView(GradientifyView()),
    AnyView(GradientFlowView()), AnyView(RainbowSherbetView()),
    AnyView(CrumpledWaveView()), AnyView(GlossyGradientsView()),
    AnyView(ColorWindView())
]

// MARK: - Rotating Gradient

struct RotatingGradientView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    var startColor: Color = .pink
    var endColor: Color = .yellow

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.07, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            RotatingGradient(time: elapsedTime*0.25, startColor: startColor, endColor: endColor)
        }
    }
}

#Preview("Rotating Gradient") { RotatingGradientView().enhancedPreview() }

// MARK: - Chroma Gradients

struct ChromaGradientsView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            ChromaGradients(time: elapsedTime)
        }
    }
}

#Preview("Chroma Gradients") { ChromaGradientsView().enhancedPreview() }

// MARK: - Fluid Gradient

// FIXME: Spread the fluids more from each other
struct FluidGradientView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.05, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            FluidGradient(time: elapsedTime)
        }
    }
}

#Preview("Fluid Gradient") { FluidGradientView().enhancedPreview() }

// MARK: - Gradientify

struct GradientifyView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.05, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            Gradientify(time: elapsedTime * 0.4)
        }
    }
}

#Preview("Gradientify") { GradientifyView().enhancedPreview() }

// MARK: - Gradient Flow

struct GradientFlowView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    /// Should be an array of 4 colors
    var colors: [Color] = [.orange, .cyan, .pink, .indigo]
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            GradientFlow(colors: colors, time: elapsedTime)
        }
    }
}

#Preview("Gradient Flow") { GradientFlowView().enhancedPreview() }

// MARK: - Rainbow Sherbet

struct RainbowSherbetView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var touch: CGPoint = .zero

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.0167, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            RainbowSherbet(time: elapsedTime * 0.25, location: touch)
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.touch = value.location
                }
                .onEnded { _ in
                    // Something cool in mind?
                }
        )
    }
}

#Preview("Rainbow Sherbet") { RainbowSherbetView().enhancedPreview() }

// MARK: - Crumpled Wave

struct CrumpledWaveView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.05, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            CrumpledWave(time: elapsedTime)
        }
    }
}

#Preview("Crumpled Wave") { CrumpledWaveView().enhancedPreview() }

// MARK: - Glossy Gradients

struct GlossyGradientsView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var touch: CGPoint = .zero

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.0167, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            GlossyGradients(time: elapsedTime, location: touch)
        }
        .gesture(
            DragGesture().onChanged { touch = $0.location }
        )
    }
}

#Preview("Glossy Gradients") { GlossyGradientsView().enhancedPreview() }

// MARK: - Color Wind

// FIXME: Looks funny on Mac
struct ColorWindView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var touch: CGPoint = .zero

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.025, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            ColorWind(time: elapsedTime, location: touch)
        }
//        .background(Color.black)
        .gesture(
            DragGesture()
                .onChanged { 
                    let location = CGPoint(x: $0.translation.width/10, y: $0.translation.height/10)
                    self.touch = location
                }
        )
    }
}

#Preview("Color Wind") { ColorWindView().enhancedPreview() }
