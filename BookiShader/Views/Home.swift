/*
 Home.swift
 Book iShader

 Created by Treata Norouzi on 5/29/24.
 
 Abstract:
 The home page of the app.
*/

import SwiftUI

typealias shaderClass = (views: [AnyView], name: String)

let shaderClassCollection: [shaderClass] = [(views: shaderArtViews, name: "Shader Art"),
    (views: transitionViews, name: "Transition"), (views: audioVisualizerViews, name: "Audio Visualization"),
    (views: colorEffectViews, name: "Color Effect"), (views: gradientViews, name: "Gradient"),
    (views: layerEffectViews, name: "Layer Effect"), (views: distortionEffectViews, name: "Distortion Effect")
]

// MARK: - Main

struct Home: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    @Environment(BassAudioEngine.self) var audioManager: BassAudioEngine
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    /// Initial number of columns
    @State private var columns: Int = 2

    #if os(macOS) || os(visionOS) ||  os(tvOS)
        var spacing: CGFloat = 35
        
        var itemBound: CGFloat { horizontalSizeClass == .compact ? 220 : 320 }
    #else
        var spacing: CGFloat = UIDevice.isPhone ? 20 : 25
        
        var itemBound: CGFloat {
            if UIDevice.isPhone {
                horizontalSizeClass == .compact ? 150 : 220
            } else {
                horizontalSizeClass == .compact ? 180 : 260
            }
        }
    #endif
    
    var body: some View {
        NavigationStack {
            GeometryReader {
                let size = $0.size
                let gridItem = GridItem(.flexible(minimum: itemBound), spacing: spacing)
                
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVGrid(columns: Array(repeating: gridItem, count: columns), spacing: spacing) {
                        ForEach(shaderClassCollection.indices, id: \.self) { index in
                            let shaderClass = shaderClassCollection[index].views
                            let className = shaderClassCollection[index].name
                            
                            NavigationLink(destination: ShaderGrid(contents: shaderClass)) {
                                VStack(alignment: .leading) {
                                    // FIXME: The first one isn't usually the most appealing ...
                                    shaderClass.first!
                                        .frame(height: itemBound)
                                        .clipShape(.rect(cornerRadius: 12))
                                    // injecting viewModels is necessary for some shaders to function
                                        .environment(hud)
                                        .environment(audioManager)
                                    
                                    Spacer(minLength: spacing/3)
                                    
                                    Text(className)
                                        .font(.system(.headline, design: .rounded))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, spacing/1.5)
                    .padding(.vertical, spacing*1.5)
                    // reactiveness of the grid
                    .onAppear { calculateColumnCount(from: size) }
                    .onChange(of: size) { _, newSize in
                        calculateColumnCount(from: newSize)
                    }
                }
            }
        }
        .frame(minWidth: 0, idealWidth: .infinity, minHeight: 0, idealHeight: .infinity)
    }
    
    // Pretty simple, but works fine. Might be changed ...
    private func calculateColumnCount(from size: CGSize) {
        let newColumns = Int((size.width + spacing) / (itemBound + spacing*1.5))
        columns = max(1, newColumns) // Ensure a minimum of 1 column
    }
}

#Preview("Home") {
    @Bindable var audioManager = BassAudioEngine(filePath: Bundle.musicPath)
    
    return Home()
        .environment(ShaderHud())
        .environment(audioManager)
        .onAppear {
            audioManager.stopMusicPlay()
        }
        .frame(minHeight: 700)
}
