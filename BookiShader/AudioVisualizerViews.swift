/*
 AudioVisualizerViews.swift
 Book iShader

 Created by Treata Norouzi on 4/2/24.
 
 Abstract:
*/

import AudioVisualizer
import SwiftUI

// TODO: New File
extension Bundle {
    static var musicPath: String? = Bundle.main.path(forResource: "Be Khod Ay", ofType: "mp3")
}

/// `BASS` framework is responsible for all the audio playback & analysis
/// which currently is only available for **iOS** & **macOS**.
#if os(iOS) || os(macOS)

// MARK: - Audio Eclipse

struct AudioEclipseView: View {
    @Bindable var audioManager: BassAudioEngine
    
    @State var paused = false
    
    @State private var startTime = Date.now
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            TimelineView(.animation(minimumInterval: 0.025, paused: paused)) { context in
                let elapsedTime = startTime.distance(to: context.date)
                
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
    AudioEclipseView(audioManager: .init(filePath: Bundle.musicPath))
}

// MARK: - Shades of Music

struct ShadesOfMusicView: View {
    @Bindable var audioManager: BassAudioEngine
    
    @State private var startTime = Date.now
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            ShadesOfMusic(time: elapsedTime, fft: audioManager.muSpectrum)
        }
        .ignoresSafeArea()
    }
}

#Preview("Shades of Music") {
    ShadesOfMusicView(audioManager: .init(filePath: Bundle.musicPath))
}

// MARK: - Sine Sound Waves

struct SineSoundWavesView: View {
    @Bindable var audioManager: BassAudioEngine
    
    @State private var startTime = Date.now
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.025)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            SineSoundWaves(time: elapsedTime, fft: audioManager.muSpectrum)
        }
        .ignoresSafeArea()
    }
}

#Preview("Sine Sound Waves") {
    SineSoundWavesView(audioManager: .init(filePath: Bundle.musicPath))
}

// MARK: - Glowing Sound Particles

struct GlowingSoundParticlesView: View {
    @Bindable var audioManager: BassAudioEngine
    
    @State private var startTime = Date.now
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            GlowingSoundParticles(time: elapsedTime, fft: audioManager.muSpectrum)
        }
        .ignoresSafeArea()
    }
}

#Preview("Glowing Sound Particles") {
    GlowingSoundParticlesView(audioManager: .init(filePath: Bundle.musicPath))
}

// MARK: - Universe Within

struct UniverseWithinView: View {
    @Bindable var audioManager: BassAudioEngine
    
    @State private var startTime = Date.now
    @State private var touch = CGPoint.zero
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.035)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            UniverseWithin(
                time: elapsedTime,
                fft: audioManager.muSpectrum,
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
    UniverseWithinView(audioManager: .init(filePath: Bundle.musicPath))
}

// MARK: - Galaxy Visuals

struct GalaxyVisualsView: View {
    @Bindable var audioManager: BassAudioEngine
    
    @State private var startTime = Date.now
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.0167)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            GalaxyVisuals(time: elapsedTime, fft: audioManager.muSpectrum)
        }
        .ignoresSafeArea()
    }
}

#Preview("Galaxy Visuals") {
    GalaxyVisualsView(audioManager: .init(filePath: Bundle.musicPath))
}

// MARK: - Round Audio Specturm

struct RoundAudioSpecturmView: View {
    @Bindable var audioManager: BassAudioEngine
    
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
    RoundAudioSpecturmView(audioManager: .init(filePath: Bundle.musicPath))
}

// MARK: - Waves Remix

struct WavesRemixView: View {
    @Bindable var audioManager: BassAudioEngine
    
    @State private var startTime = Date.now
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            WavesRemix(time: elapsedTime, fft: audioManager.muSpectrum)
        }
        .ignoresSafeArea()
    }
}

#Preview("Waves Remix") {
    WavesRemixView(audioManager: .init(filePath: Bundle.musicPath))
}

#endif
