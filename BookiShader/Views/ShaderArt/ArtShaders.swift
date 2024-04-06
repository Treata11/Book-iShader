/*
 ArtShaders.swift
 Book iShader

 Created by Treata Norouzi on 4/5/24.
 
 Abstract:
 A ContainerView which showcases the collection of all ShaderArtViews
*/

import SwiftUI

// !!!: WIP

struct ArtShaders: View {
    @Bindable var hud = ShaderHud()
    
    var body: some View {
        NavigationStack {
            GeometryReader {
                let size = $0.size
//                let safeArea = $0.safeAreaInsets
                
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVGrid(
                        columns: Array(repeating: GridItem(
                            .adaptive(minimum: size.width/3, maximum: size.width/2), 
                            spacing: 25), count: 2
                        ),
                        spacing: size.width/20
                    ) {
                        ForEach(shaderArtViews.indices, id: \.self) { index in
                            VStack {
                                shaderArtViews[index]
                                Text(shaderArtViews[index].extractedStructName)
                            }
                                .frame(width: (size.width) / 2.3, height: (size.width) / 2.3)
                                .clipShape(.rect(cornerRadius: size.width/33.6))
                                .contextMenu(menuItems: {
                                    Text(shaderArtViews[index].extractedStructName)
                                }, preview: {
                                    @Bindable var hud_ = ShaderHud()
                                    
                                    shaderArtViews[index]
                                        .environment(hud_)
                                        .frame(width: size.width, height: size.width)
                                        .onAppear { hud_.paused = false }
                                        .onDisappear { hud_.paused = true }
                                })
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        // injecting the ViewModel(s) to the Stack
        .environment(hud)
    }
}

#Preview("Art Shaders") { ArtShaders() }

// MARK: - Cheap and resource-extensive structName extraction

extension AnyView {
    // Perhaps cheap, but I wanted it this way for now.
    var extractedStructName: String {
        let description = String(describing: self)
        guard let start = description.range(of: ".")?.upperBound,
              let end = description.range(of: ">")?.lowerBound else {
            return "Struct name not found"
        }
        
        let structNameWithExtra = String(description[start..<end])
        let structNameComponents = structNameWithExtra.components(separatedBy: ".")
        
        if structNameComponents.count >= 2 {
            var cleanedStructName = structNameComponents[structNameComponents.count - 1]
            if cleanedStructName.hasSuffix("View") {
                cleanedStructName = String(cleanedStructName.dropLast(4))
            }
            return cleanedStructName
        }
        
        return "Unknown"
    }
}
