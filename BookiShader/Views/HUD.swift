/*
 HUD.swift
 Book iShader

 Created by Treata Norouzi on 4/8/24.
 
 Abstract:
 The View of ShaderHud model
*/

import SwiftUI

// !!!: WIP

// TODO: Playback-Speed picker
struct HUD: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @Environment((\.colorScheme)) private var colorScheme
    
    /// The default `TimeInterval` to either **rewind** or **fast-forward**
    var iterationTime: TimeInterval = 5
    
    var body: some View {
        HStack(spacing: 5) {
            Button(action: {
                hud.rewind(seconds: iterationTime)
            }, label: {
                Image(systemName: "gobackward.5")
            })
            
            Button(action: {
                hud.paused.toggle()
            }, label: {
                hud.paused ? Image(systemName: "play.fill") : Image(systemName: "pause.fill")
            })
            
            Button(action: {
                hud.fastForward(seconds: iterationTime)
            }, label: {
                Image(systemName: "goforward.5")
            })
            
            Spacer()
            
            // Needs a seperate timer in `ShaderHud` which is inconvenient
            Text("TODO: Elapsed Time")
        }
        .padding(.horizontal, 7.5)
        .padding(.vertical, 2.5)
        .background {
            Color(colorScheme == .light ? .lightGray : .darkGray)
        }
    }
}

#Preview("HUD") { HUD().enhancedPreview(preferredColorScheme: .light) }

// TODO: - Add in ColorExtensions -

extension Color {
    #if os(macOS)
    
    static let lightGray = Color(nsColor: .lightGray)
    static let darkGray = Color(nsColor: .darkGray)

    #else
    
    static let systemGray = Color(uiColor: .systemGray)
    static let systemGray2 = Color(uiColor: .systemGray2)
    static let systemGray3 = Color(uiColor: .systemGray3)
    static let systemGray4 = Color(uiColor: .systemGray4)
    static let systemGray5 = Color(uiColor: .systemGray5)
    static let systemGray6 = Color(uiColor: .systemGray6)
    
    static let lightGray = Color.systemGray6
    static let darkGray = Color.systemGray
    
    #endif
}
