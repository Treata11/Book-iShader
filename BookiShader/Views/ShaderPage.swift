/*
 ShaderPage.swift
 Book iShader

 Created by Treata Norouzi on 4/8/24.
 
 Abstract:
 An environment to View and manipulate shader arguments
*/

import SwiftUI

// !!!: WIP

// TODO: The code of the shader function could also be displayed in this page
// prabably not possible, since metal resources are precompiled in swift packages

struct ShaderPage: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @Environment(\.scenePhase) private var scenePhase
    
    var shaderView: AnyView
    /// Name of the shader
    var name: String
    
    @State private var showHUD = false
    
    var body: some View {
        VStack(alignment: .leading) {
            shaderView
                .aspectRatio(4/3, contentMode: .fit)
            // The HUD
                .overlay(alignment: .bottom) {
                    if showHUD {
                        HUD()
                            .transition(.blurReplace)
//                            .transition(.offset(y: 25))
                    }
                }
                .onHover { hovering in
                    withAnimation(.easeIn(duration: 0.333)) {
                        showHUD = hovering
                    }
                }
                
            SourceCodeView(shaderName: name)
        }
    #if !os(visionOS) || !os(macOS) // Hovering does the job in the two platforms
        .onTapGesture {
            withAnimation(.easeIn(duration: 0.333)) {
                showHUD.toggle()
            }
        }
    #endif
        .onChange(of: scenePhase) { _, newPhase in
            // Deactivate the `ShaderHud` timer when inactive
            if newPhase != .active { hud.paused = false }
            print("ShaderPage phase: \(newPhase)")
        }
        .onDisappear {
            hud.stopTimer()
        }
    }
}

#Preview("ShaderPage") {
    ShaderPage(shaderView: AnyView(HypnoticRipplesView()), name: "HypnoticRipples")
        .enhancedPreview(width: 600, heigth: 640, preferredColorScheme: .light)
}
