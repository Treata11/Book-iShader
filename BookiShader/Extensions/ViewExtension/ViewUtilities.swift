/*
 ViewUtilities.swift

 Created by Treata Norouzi on 3/5/24.
 
 Abstract:
 General purpose extensions used in Views.
*/

import SwiftUI

extension View {
#if DEBUG
    /**
     A `debugging` helper method which injects the `ViewModels` of the app to the containing view and
     provides some other enhancements, useful while `previewing`.
     */
    func enhancedPreview(width: CGFloat = 400, heigth: CGFloat = 300, preferredColorScheme: ColorScheme = .dark) -> some View {
        @Bindable var hud = ShaderHud()
        
        return ZStack {
            // Provide a grayish background only for debuggin purposes...
            preferredColorScheme == .dark ? Color.midnightGray.opacity(0.7) : Color.slateGray.opacity(0.3)
            self
        }
        // Injecting the ViewModel(s) of the app
        .environment(hud)
        
        // Modifying the looks
        #if os(macOS)
        .frame(width: width, height: heigth)
        #endif
        .preferredColorScheme(preferredColorScheme)
    }
#endif
}

// MARK: - Color

extension Color {
    /// #SyntacticSugar
    init(_ red: Double, _ green: Double, _ blue: Double) {
        self.init(red: red/255, green: green/255, blue: blue/255)
    }
}
    
extension Color {
    static let prussianBlue = Color(15, 48, 91)
    static let blueSapphire = Color(27, 86, 177)
    static let almond = Color(171, 120, 78)
    static let caramel = Color(182, 114, 51)
    static let greenEye = Color(125, 149, 109)
    static let slateGray = Color(87, 92, 98)
    static let charcoalGray = Color(53, 55, 57)
    static let steel = Color(81, 81, 81)
    static let shadowGray = Color(41, 42, 47)
    static let midnightGray = Color(36, 39, 48)
    static let cream = Color(252, 249, 232)
}

// MARK: - UIDevice

#if os(iOS)
extension UIDevice {
    static var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
#endif
