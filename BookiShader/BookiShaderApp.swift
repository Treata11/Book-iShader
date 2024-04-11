/*
 BookiShaderApp.swift
 Book iShader

 Created by Treata Norouzi on 4/2/24.
*/

import SwiftUI

@main
struct BookiShaderApp: App {
    @Bindable private var shaderHud = ShaderHud()
    
    var body: some Scene {
        WindowGroup {
            ArtShaders()
                .environment(shaderHud)
        }
    }
}
