/*
 AudioVisualizerViews.swift
 Book iShader

 Created by Treata Norouzi on 4/2/24.
 
 Abstract:
 The Views in which AudioVisualizer shaders are demonstrated in
*/

import AudioVisualizer
import SwiftUI

let audioVisualizerViews: [AnyView] = [
    AnyView(AudioEclipseView()), AnyView(ShadesOfMusicView()),
    AnyView(SineSoundWavesView()), AnyView(GlowingSoundParticlesView()),
    AnyView(UniverseWithinView()), AnyView(GalaxyVisualsView()),
    AnyView(RoundAudioSpecturmView()), AnyView(WavesRemixView())
]

// TODO: New File
extension Bundle {
    static var musicPath: String? = Bundle.main.path(forResource: "Be Khod Ay", ofType: "mp3")
}

/// `BASS` framework is responsible for all the audio playback & analysis
/// which currently is only available for **iOS** & **macOS**.
#if os(iOS) || os(macOS)

// MARK: - Audio Eclipse

struct AudioEclipseView: View {
    @Environment(BassAudioEngine.self) var audioManager
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            TimelineView(.animation(minimumInterval: 0.025, paused: hud.paused)) { context in
                let elapsedTime = hud.startTime.distance(to: context.date)
                
                AudioEclipse(time: elapsedTime, fft: audioManager.muSpectrum)
                    .overlay {
                        Circle()
                            .foregroundStyle(.thinMaterial)
                            .preferredColorScheme(.dark)
                            .frame(width: min(size.width, size.height) * 0.7)
                            .blur(radius: 15)
                            .shadow(radius: 15, x: 0, y: 0)
                    }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview("Audio Eclipse") {
    AudioEclipseView()
        .environment(BassAudioEngine(filePath: Bundle.musicPath))
        .enhancedPreview()
}

// MARK: - Shades of Music

struct ShadesOfMusicView: View {
    @Environment(BassAudioEngine.self) var audioManager
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            ShadesOfMusic(time: elapsedTime, fft: audioManager.muSpectrum)
        }
        .ignoresSafeArea()
    }
}

#Preview("Shades of Music") {
    ShadesOfMusicView()
        .environment(BassAudioEngine(filePath: Bundle.musicPath))
        .enhancedPreview()
}

// MARK: - Sine Sound Waves

struct SineSoundWavesView: View {
    @Environment(BassAudioEngine.self) var audioManager
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.025, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            SineSoundWaves(time: elapsedTime, fft: audioManager.muSpectrum)
        }
        .ignoresSafeArea()
    }
}

#Preview("Sine Sound Waves") {
    SineSoundWavesView()
        .environment(BassAudioEngine(filePath: Bundle.musicPath))
        .enhancedPreview()
}

// MARK: - Glowing Sound Particles

struct GlowingSoundParticlesView: View {
    @Environment(BassAudioEngine.self) var audioManager
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            GlowingSoundParticles(time: elapsedTime, fft: audioManager.muSpectrum)
        }
        .ignoresSafeArea()
    }
}

#Preview("Glowing Sound Particles") {
    GlowingSoundParticlesView()
        .environment(BassAudioEngine(filePath: Bundle.musicPath))
        .enhancedPreview()
}

// MARK: - Universe Within

struct UniverseWithinView: View {
    @Environment(BassAudioEngine.self) var audioManager
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var touch = CGPoint.zero
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.035, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            UniverseWithin(
                time: elapsedTime,
                fft: audioManager.spectrum,
                location: touch)
        }
        .ignoresSafeArea()
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    self.touch = value.location
                }
        )
    }
}

#Preview("Universe Within") {
    UniverseWithinView()
        .environment(BassAudioEngine(filePath: Bundle.musicPath))
        .enhancedPreview()
}

// MARK: - Galaxy Visuals

struct GalaxyVisualsView: View {
    @Environment(BassAudioEngine.self) var audioManager
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.0167, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            GalaxyVisuals(time: elapsedTime, fft: audioManager.muSpectrum)
        }
        .ignoresSafeArea()
    }
}

#Preview("Galaxy Visuals") {
    GalaxyVisualsView()
        .environment(BassAudioEngine(filePath: Bundle.musicPath))
        .enhancedPreview()
}

// MARK: - Round Audio Specturm

struct RoundAudioSpecturmView: View {
    @Environment(BassAudioEngine.self) var audioManager
    
    var backgroundColor: Color = .black
    var rayCount: Int = 78
    
    var body: some View {
        RoundAudioSpecturm(
            fft: audioManager.muSpectrum,
            backgroundColor: backgroundColor,
            rayCount: rayCount
        )
            .ignoresSafeArea()
//            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview("Round Audio Specturm") {
    RoundAudioSpecturmView()
        .environment(BassAudioEngine(filePath: Bundle.musicPath))
}

// MARK: - Waves Remix

struct WavesRemixView: View {
    @Environment(BassAudioEngine.self) var audioManager
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02, paused: hud.paused)) { context in
            let elapsedTime = hud.startTime.distance(to: context.date)
            
            WavesRemix(time: elapsedTime, fft: audioManager.muSpectrum)
        }
        .ignoresSafeArea()
    }
}

#Preview("Waves Remix") {
    WavesRemixView()
        .environment(BassAudioEngine(filePath: Bundle.musicPath))
        .enhancedPreview()
}

#endif
