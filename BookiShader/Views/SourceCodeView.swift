/*
 SourceCodeView.swift
 Book iShader

 Created by Treata Norouzi on 5/23/24.
 
 Abstract:
 
*/

import SwiftUI
import Splash

// FIXME: No syntax-coloring onAppear

struct SourceCodeView: View {
    @StateObject var context = ShaderTextEditorContext()
    @Binding var sourceString: NSAttributedString

    let theme: Splash.Theme
    let sourceHighlighter: SyntaxHighlighter<AttributedStringOutputFormat>

    init(sourceString: Binding<NSAttributedString>, editorModel: ShaderEditor) {
        self._sourceString = sourceString
        self.theme = editorModel.theme
        self.sourceHighlighter = editorModel.sourceHighlighter
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ShaderTextEditor(text: $sourceString, context: context) { textView in
                textView.backgroundColor = theme.backgroundColor
                textView.insertionPointColor = NSColor.white
            }
            .onChange(of: context.attributedString) { _, newContents in
                guard let newString = newContents?.string else { return }
                // Re-highlight text on every keystroke. This might look like
                // it leads to an infinite loop, but updates via the context
                // are designed not to cause changes to be published back to us
                context.attributedString = sourceHighlighter.highlight(newString)
            }
        }
    }
}

#Preview("Source Code View") {
    @Environment((\.colorScheme)) var colorScheme
    
    @Bindable var editorModel = ShaderEditor(shaderName: "CRT", colorScheme: colorScheme)
    
    return SourceCodeView(sourceString: $editorModel.sourceString, editorModel: editorModel)
}
