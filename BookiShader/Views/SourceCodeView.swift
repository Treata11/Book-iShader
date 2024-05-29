/*
 SourceCodeView.swift
 Book iShader

 Created by Treata Norouzi on 5/23/24.
 
 Abstract:
 
*/

import SwiftUI
import CodeEditor

struct SourceCodeView: View {
    var shaderName: String
    
    @State private var source = "// No Sources found!"
    
    @Environment((\.colorScheme)) var colorScheme
    
    #if os(macOS)
        @AppStorage("fontsize") var fontSize = Int(NSFont.systemFontSize)
    #endif
      
    init(shaderName: String) { self.shaderName = shaderName }
    
    private var theme: CodeEditor.ThemeName {
        (colorScheme == .light) ? .init(rawValue: "xcode") : .init(rawValue: "atom-one-dark")
    }

    var body: some View {
        Group {
            #if os(macOS)
                CodeEditor(source: $source, language: .cpp, theme: theme,
                           fontSize: .init(get: { CGFloat(fontSize)  },
                                       set: { fontSize = Int($0) }))
                    .frame(minWidth: 120)
            #else
                CodeEditor(source: $source, language: .cpp, theme: theme)
            #endif
        }
        .onAppear {
            source = findSourceString(of: shaderName)
            print("SourceCodeView; Shader Name: \(shaderName)")
        }
    }
}

#Preview("Source Code View") {
    SourceCodeView(shaderName: "CRT")
}

// MARK: - Source Code

// TODO: Find a better way to extract the source-code from iShader lib
func findSourceString(of shader: String) -> String {
    let url =
        Bundle.shaderArt.url(forResource: "Shaders/" + shader, withExtension: "metal") ??
        Bundle.colorEffect.url(forResource: "Shaders/" + shader, withExtension: "metal") ??
        Bundle.transition.url(forResource: "Shaders/" + shader, withExtension: "metal") ??
        Bundle.layerEffect.url(forResource: "Shaders/" + shader, withExtension: "metal") ??
        Bundle.distortionEffect.url(forResource: "Shaders/" + shader, withExtension: "metal") ??
        Bundle.audioVisualizer.url(forResource: "Shaders/" + shader, withExtension: "metal") ??
        Bundle.shaderArt.url(forResource: "Shaders/Gradients/" + shader, withExtension: "metal")
    
    return (try? String(contentsOf: url ?? Bundle.empty))!
}

extension Bundle {
    static let empty = Bundle.main.url(forResource: "Empty", withExtension: nil)!
}
