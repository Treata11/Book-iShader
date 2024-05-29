//
//  ViewTests.swift
//  Book iShader
//
//  Created by Treata Norouzi on 5/29/24.
//

import SwiftUI
import CodeEditor

private struct CodeEditorTests: View {
  
    #if os(macOS)
        @AppStorage("fontsize") var fontSize = Int(NSFont.systemFontSize)
    #endif
    
    @State private var source = 
        """
        #include <metal_stdlib>
        using namespace metal;


        [[ stitchable ]] half4 vibrance(float2 position, half4 color, float percentage) {
            float average = (color.r + color.g + color.b) / 3;
            float mx = max(color.r, max(color.g, color.b));
            float amount = (mx - average) * percentage * 3 * 5;
            
            return color - (mx - color) * amount;
        }
        """
    @State private var language = CodeEditor.Language.cpp
    @State private var theme    = CodeEditor.ThemeName(rawValue: "xcode") /*CodeEditor.ThemeName.pojoaque*/

  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Picker("Language", selection: $language) {
          ForEach(CodeEditor.availableLanguages) { language in
            Text("\(language.rawValue.capitalized)")
              .tag(language)
          }
        }
        Picker("Theme", selection: $theme) {
          ForEach(CodeEditor.availableThemes) { theme in
            Text("\(theme.rawValue.capitalized)")
              .tag(theme)
          }
        }
      }
      .padding()
    
      Divider()
    
      #if os(macOS)
        CodeEditor(source: $source, language: language, theme: theme,
                   fontSize: .init(get: { CGFloat(fontSize)  },
                                   set: { fontSize = Int($0) }))
          .frame(minWidth: 640, minHeight: 480)
      #else
        CodeEditor(source: $source, language: language, theme: theme)
      #endif
    }
  }
}

#Preview("Code Editor Tests") { CodeEditorTests() }
