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

struct ShaderPage: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
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
                
            Text(name)
                .font(.system(.callout))
        }
        .onTapGesture {
            withAnimation(.easeIn(duration: 0.333)) {
                showHUD.toggle()
            }
        }
    }
}

#Preview("ShaderPage") {
    ShaderPage(shaderView: AnyView(HypnoticRipplesView()), name: "Hypnotic Ripples")
        .enhancedPreview(preferredColorScheme: .light)
}
