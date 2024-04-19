/*
 BookiShaderApp.swift
 Book iShader

 Created by Treata Norouzi on 4/2/24.
*/

import SwiftUI

@main
struct BookiShaderApp: App {
    @Bindable private var shaderHud = ShaderHud()
    @Bindable private var audioManager = BassAudioEngine(filePath: Bundle.musicPath, fps: 60)
    
    var body: some Scene {
        WindowGroup {
//            ArtShaders()
//            AudioVisualizers()
            GridLoopOfShaders()
                .environment(shaderHud)
                .environment(audioManager)
        }
    }
}
