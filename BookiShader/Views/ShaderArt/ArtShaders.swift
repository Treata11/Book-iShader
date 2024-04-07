/*
 ArtShaders.swift
 Book iShader

 Created by Treata Norouzi on 4/5/24.
 
 Abstract:
 A ContainerView which showcases the collection of all ShaderArtViews
*/

import SwiftUI

struct ArtShaders: View {
    @Bindable var hud = ShaderHud()
    
    private let shaderViews = shaderArtViews + gradientViews
    
    var body: some View {
        NavigationStack {
            ShaderGrid(contents: shaderViews)
        }
        // injecting the ViewModel(s) to the Stack
        .environment(hud)
    }
}

#Preview("Art Shaders") { ArtShaders() }
