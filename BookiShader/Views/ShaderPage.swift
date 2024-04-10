/*
 ShaderPage.swift
 Book iShader

 Created by Treata Norouzi on 4/8/24.
 
 Abstract:
 An environment to View and manipulate shader arguments
*/

import SwiftUI

// !!!: WIP

struct ShaderPage: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    var shaderView: AnyView
    var name: String
    
    var body: some View {
        VStack {
            
            shaderView
        }
        .overlay(alignment: .bottom) {
            HUD()
        }
    }
}

#Preview("ShaderPage") {
    ShaderPage(shaderView: AnyView(HypnoticRipplesView()), name: "HypnoticRipples")
        .enhancedPreview(preferredColorScheme: .light)
}
