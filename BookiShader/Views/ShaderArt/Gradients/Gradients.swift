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
        RotatingGradient(time: hud.elapsedTime, startColor: startColor, endColor: endColor)
    }
}

#Preview("Rotating Gradient") { RotatingGradientView().enhancedPreview() }

// MARK: - Chroma Gradients

struct ChromaGradientsView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        ChromaGradients(time: hud.elapsedTime)
    }
}

#Preview("Chroma Gradients") { ChromaGradientsView().enhancedPreview() }

// MARK: - Fluid Gradient

// FIXME: Spread the fluids more from each other
struct FluidGradientView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        FluidGradient(time: hud.elapsedTime)
    }
}

#Preview("Fluid Gradient") { FluidGradientView().enhancedPreview() }

// MARK: - Gradientify

struct GradientifyView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        Gradientify(time: hud.elapsedTime)
    }
}

#Preview("Gradientify") { GradientifyView().enhancedPreview() }

// MARK: - Gradient Flow

struct GradientFlowView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    /// Should be an array of 4 colors
    var colors: [Color] = [.orange, .cyan, .pink, .indigo]
    
    var body: some View {
        GradientFlow(colors: colors, time: hud.elapsedTime)
    }
}

#Preview("Gradient Flow") { GradientFlowView().enhancedPreview() }

// MARK: - Rainbow Sherbet

struct RainbowSherbetView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var touch: CGPoint = .zero

    var body: some View {
        RainbowSherbet(time: hud.elapsedTime, location: touch)
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
        CrumpledWave(time: hud.elapsedTime)
    }
}

#Preview("Crumpled Wave") { CrumpledWaveView().enhancedPreview() }

// MARK: - Glossy Gradients

struct GlossyGradientsView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var touch: CGPoint = .zero

    var body: some View {
        GlossyGradients(time: hud.elapsedTime, location: touch)
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
        ColorWind(time: hud.elapsedTime, location: touch)
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
