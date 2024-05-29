/*
 ColorEffectViews.swift
 Book iShader

 Created by Treata Norouzi on 4/4/24.

 Abstract:
 
*/

import ColorEffect
import SwiftUI

let colorEffectViews: [AnyView] = [
    AnyView(Luminence()), AnyView(Εxposure()),
    AnyView(Gamma()), AnyView(Vibrance()),
    AnyView(Vignette()), AnyView(NightVision()),
    AnyView(Infrared()), AnyView(CRT()),
    AnyView(LightbulbScreen()), AnyView(FilmGrain()),
    AnyView(TileableWaterCaustic())
]

// MARK: - Luminence

struct Luminence: View {
    var body: some View {
        subjectView
            .luminence()
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("Luminence") { Luminence() }

// MARK: - Εxposure

struct Εxposure: View {
    @State var exposureValue: Float = .zero
    
    var body: some View {
        VStack {
            subjectView
                .exposure(value: exposureValue)
            Slider(value: $exposureValue, in: -1...1)
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

#Preview("Εxposure") { Εxposure() }

// MARK: - Gamma

struct Gamma: View {
    /// The actual value ranges from `[0 2.2]`
    @State var gammaValue: Float = 0.5
    
    var body: some View {
        VStack {
            subjectView
                .gamma(value: gammaValue)
            Slider(value: $gammaValue, in: 0...1)
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

#Preview("Gamma") { Gamma() }

// MARK: - Vibrance

struct Vibrance: View {
    @State var vibranceValue: Float = .zero
    
    var body: some View {
        VStack {
            subjectView
                .vibrance(value: vibranceValue)
            Slider(value: $vibranceValue, in: 0...1)
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

#Preview("Vibrance") { Vibrance() }

// MARK: - Vignette

struct Vignette: View {
    @State var vignetteValue: Float = .zero
    
    var body: some View {
        VStack {
            subjectView
                .vignette(value: vignetteValue)
            Slider(value: $vignetteValue, in: -1...1)
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

#Preview("Vignette") { Vignette() }

// MARK: - Night Vision

struct NightVision: View {
    @State var paused = false
    
    @State private var startTime = Date.now
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.07, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            subjectView
                .nightVision(time: elapsedTime)
        }
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("Night Vision") { NightVision() }

// MARK: - Infrared

struct Infrared: View {
    var body: some View {
        subjectView
            .infrared()
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("Infrared") { Infrared() }

// MARK: - CRT

struct CRT: View {
    var body: some View {
        subjectView
            .crt()
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("CRT") { CRT() }

// MARK: - Lightbulb Screen

struct LightbulbScreen: View {
    @State var bulbCount = 64
    
    var body: some View {
        subjectView
            .lightbulbScreen(bulbCount: bulbCount)
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("Lightbulb Screen") { LightbulbScreen() }

// MARK: - Film Grain

struct FilmGrain: View {
    @State private var startTime: Date = .now
    
    @State var strength: Float = 32
    @State var fineGrain = true
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.05)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            VStack {
                subjectView
                    .filmGrain(time: elapsedTime, strength: strength, fineGrain: fineGrain)
                
                Slider(value: $strength, in: 16...96)
                    .padding()
            }
        }
        .onTapGesture { fineGrain.toggle() }
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("Film Grain") { FilmGrain() }

// MARK: - Tileable Water Caustic

struct TileableWaterCaustic: View {
    @State private var startTime: Date = .now
    
    @State var showTiling = false

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.025)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            subjectView
                .tileableWaterCaustic(time: elapsedTime * 0.5, showTiling: showTiling)
        }
        .onTapGesture { showTiling.toggle() }
    }
    
    // Change based on needs
    var subjectView: some View {
        Image(.pufferFishShader)
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview("Tileable Water Caustic") { TileableWaterCaustic() }
