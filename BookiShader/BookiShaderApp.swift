/*
 BookiShaderApp.swift
 Book iShader

 Created by Treata Norouzi on 4/2/24.
*/

import SwiftUI

@main
struct BookiShaderApp: App {
    @Bindable var manager = ShaderHud()
    @Bindable var audioManager = BassAudioEngine(filePath: Bundle.musicPath)
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environment(manager)
                .environment(audioManager)
                .onAppear {
                    audioManager.stopMusicPlay()
                }
        }
    }
}
