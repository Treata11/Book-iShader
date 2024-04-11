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

            // TODO: Fixed position for each digit
            Text(hud.elapsedTime.truncated(toDecimalPlaces: 2).description)
        }
        .padding(.horizontal, 7.5)
        .padding(.vertical, 2.5)
        
//        .background {
//            Color(colorScheme == .light ? .lightGray : .darkGray)
//        }
    }
}

#Preview("HUD") { HUD().enhancedPreview(preferredColorScheme: .light) }
