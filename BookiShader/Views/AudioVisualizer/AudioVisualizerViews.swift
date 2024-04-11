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
            
            AudioEclipse(time: hud.elapsedTime, fft: audioManager.muSpectrum)
                .overlay {
                    Circle()
                        .foregroundStyle(.thinMaterial)
                        .preferredColorScheme(.dark)
                        .frame(width: min(size.width, size.height) * 0.7)
                        .blur(radius: 15)
                        .shadow(radius: 15, x: 0, y: 0)
                }
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
        ShadesOfMusic(time: hud.elapsedTime, fft: audioManager.muSpectrum)
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
        SineSoundWaves(time: hud.elapsedTime, fft: audioManager.muSpectrum)
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
        GlowingSoundParticles(time: hud.elapsedTime, fft: audioManager.muSpectrum)
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
        UniverseWithin(
            time: hud.elapsedTime,
            fft: audioManager.spectrum,
            location: touch
        )
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { self.touch = $0.location }
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
        GalaxyVisuals(time: hud.elapsedTime, fft: audioManager.muSpectrum)
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
        WavesRemix(time: hud.elapsedTime, fft: audioManager.muSpectrum)
    }
}

#Preview("Waves Remix") {
    WavesRemixView()
        .environment(BassAudioEngine(filePath: Bundle.musicPath))
        .enhancedPreview()
}

#endif
