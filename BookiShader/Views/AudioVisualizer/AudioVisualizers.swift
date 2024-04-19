/*
 AudioVisualizers.swift
 Book iShader

 Abstract:
 A ContainerView which showcases the collection of all AudioVisualizer Views
*/

import SwiftUI

struct AudioVisualizers: View {
    @Environment(BassAudioEngine.self) var audioManager
    
    var body: some View {
        NavigationStack {
            settings
            
            ShaderGrid(contents: audioVisualizerViews)
        }
    }
    
    // DEMO_WARE
    var settings: some View {
        HStack {
            Button(action: {                                        // "Pause / Resume" button
                if( audioManager.isPaused ) { audioManager.startMusicPlay() } // User clicked on "Resume"
                else { audioManager.pauseMusicPlay() }                   // User clicked on "Pause"
                audioManager.isPaused.toggle()
            } ) {
                Text("Play / Pause")
            }
            .help("This button pauses or resumes the audio.")
            .disabled(audioManager.micOn)            // gray-out Pause/Resume button if micOn is true
            .disabled(usingBlackHole)           // gray-out Pause/Resume button when using BlackHole
            .padding(.trailing)
            
            Button(action: {
                audioManager.micOn.toggle()
                audioManager.stopMusicPlay()
                audioManager.processAudio()
            }, label: {
                audioManager.micOn ? Image(systemName:"mic.slash.fill") : Image(systemName:"mic.fill")
            })
            .help("This button turns the microphone on and off.")
//                .disabled(pauseButtonIsPaused)   // gray-out MicOn/Off button if pauseButtonIsPaused is true
            .padding(.trailing)
            
            
        }
    }
}

#Preview {
    AudioVisualizers()
        .environment(BassAudioEngine(filePath: Bundle.musicPath, fps: 60))
        .enhancedPreview()
}
