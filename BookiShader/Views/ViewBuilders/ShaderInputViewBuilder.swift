/*
 ShaderInputViewBuilder.swift
 Book iShader

 Created by Treata Norouzi on 4/10/24.
 
 Abstract:
 A SettingsView for arguments of shaders
*/

import SwiftUI

// !!!: WIP

func shaderInputViewBuilder(
    inputSettings view: some View,
    isPresented: Binding<Bool>
) -> some View {
    return NavigationStack {
        ScrollView(.vertical) {
            HUD()
            
            view
        }
        .padding()
        // The Done button
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Done") { isPresented.wrappedValue = false }
            }
        }
    }
}

// MARK: - Preview

private struct ShaderInputViewBuilder_Preview: View {
    @State var isPresented = true
    
    var body: some View {
        Button("Display ViewBuilder") { isPresented = true }
            .sheet(isPresented: $isPresented) {
                shaderInputViewBuilder(
                    inputSettings: hypotheticShaderSettings,
                    isPresented: $isPresented
                )
            }
    }
    
    var hypotheticShaderSettings: some View {
        Group {
            Toggle("some Toggle", isOn: .constant(true))
            
            Slider(value: .constant(1))
            Slider(value: .constant(5))
            Slider(value: .constant(0.2))
        }
    }
}

#Preview { ShaderInputViewBuilder_Preview() }
