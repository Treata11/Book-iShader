/*
 BookiShaderApp.swift
 Book iShader

 Created by Treata Norouzi on 4/2/24.
*/

import SwiftUI

@main
struct BookiShaderApp: App {
    @Bindable var manager = ShaderHud()
    
    var body: some Scene {
        WindowGroup {
//            ArtShaders()
//            AudioVisualizers()
            
//            Transitions()
            
            ShaderGrid(contents: gradientViews)
                .environment(manager)
        }
    }
}
