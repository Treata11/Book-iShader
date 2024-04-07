/*
 ShaderGrid.swift
 Book iShader

 Created by Treata Norouzi on 4/7/24.
 
 Abstract:
 A flexible and reactive multiplatform Grid, suitable to display a collection of
 ShaderViews
*/

import SwiftUI

struct ShaderGrid: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    /// The collection of `ShaderViews` to be displayed in the grid
    var contents: [AnyView]
    
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
        GeometryReader {
            let size = $0.size
            let gridItem = GridItem(.flexible(minimum: itemBound), spacing: spacing)
            
            ScrollView(.vertical, showsIndicators: true) {
                LazyVGrid(columns: Array(repeating: gridItem, count: columns), spacing: spacing) {
                    ForEach(contents.indices, id: \.self) { index in
                        let shaderView = contents[index]
                        
                        VStack(alignment: .leading) {
                            shaderView
                                .frame(height: itemBound)
                                .clipShape(.rect(cornerRadius: 12))
                            
                            Spacer(minLength: spacing/3)
                            Text(shaderView.extractedStructName)
                                .font(.system(.headline, design: .rounded))
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
        .frame(minWidth: 0, idealWidth: .infinity, minHeight: 0, idealHeight: .infinity)
    }
    
    // Pretty simple, but works fine. Might be changed ...
    private func calculateColumnCount(from size: CGSize) {
        let newColumns = Int((size.width + spacing) / (itemBound + spacing*1.5))
        columns = max(1, newColumns) // Ensure a minimum of 1 column
    }
}

#Preview("Shader Grid") {
    ShaderGrid(contents: gradientViews)
        .environment(ShaderHud())
}

// MARK: - Cheap and resource-intensive structName extraction

extension AnyView {
    // Perhaps cheap, but I wanted it this way for now.
    var extractedStructName: String {
        let description = String(describing: self)
        guard let start = description.range(of: ".")?.upperBound,
              let end = description.range(of: ">")?.lowerBound else {
            return "Unknown"
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
