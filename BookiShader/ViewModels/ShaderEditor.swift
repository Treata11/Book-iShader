/*
 ShaderEditor.swift
 Book iShader

 Created by Treata Norouzi on 5/23/24.
 
 Abstract:
 
*/

/*
import Splash
import SwiftUI

// import iShader
import ShaderArt
import ColorEffect
import Transition
import LayerEffect
import DistortionEffect

let sourceCodeFont = Splash.Font(name: "Menlo", size: 11.0)

@Observable
class ShaderEditor {
    
    var shaderName: String {
        didSet {
            findSourceStringInModules()
        }
    }
    
    var sourceString: NSAttributedString = .init(string: " ")
    
    let theme: Theme
    let grammar = MetalGrammar()
    let sourceHighlighter: SyntaxHighlighter<AttributedStringOutputFormat>
    
    init(shaderName: String, colorScheme: ColorScheme = .light) {
        self.shaderName = shaderName
        
        theme = (colorScheme == .light) ? .presentation(withFont: sourceCodeFont) : .wwdc18(withFont: sourceCodeFont)
        sourceHighlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: theme),
                                              grammar: grammar)
        
        findSourceStringInModules()
    }
    
    // TODO: Find a better way to extract the source-code from iShader lib
    func findSourceStringInModules() {
        let url =
            Bundle.shaderArt.url(forResource: "Shaders/" + shaderName, withExtension: "metal") ??
            Bundle.colorEffect.url(forResource: "Shaders/" + shaderName, withExtension: "metal") ??
            Bundle.transition.url(forResource: "Shaders/" + shaderName, withExtension: "metal") ??
            Bundle.layerEffect.url(forResource: "Shaders/" + shaderName, withExtension: "metal") ??
            Bundle.distortionEffect.url(forResource: "Shaders/" + shaderName, withExtension: "metal") ??
            Bundle.audioVisualizer.url(forResource: "Shaders/" + shaderName, withExtension: "metal")
        
        // FIXME: ForceUnwrapped nil URL
        let sourceCode = (try? String(contentsOf: url!)) ?? "// No Sources Found"
        self.sourceString = .init(string: sourceCode)
    }
}
*/
