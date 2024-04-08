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
        self.init(red: red, green: green, blue: blue)
    }
}
    
extension Color {
    static let prussianBlue = Color(0.0588, 0.1882, 0.3569)
    static let blueSapphire = Color(0.1059, 0.3373, 0.6941)
    static let almond = Color(0.6706, 0.4706, 0.3056)
    static let caramel = Color(0.7138, 0.4471, 0.2)
    static let greenEye = Color(0.4902, 0.5843, 0.4275)
    static let slateGray = Color(0.3412, 0.3608, 0.3843)
    static let charcoalGray = Color(0.2078, 0.2157, 0.2235)
    static let steel = Color(0.3176, 0.3176, 0.3176)
    static let shadowGray = Color(0.1608, 0.1647, 0.1843)
    static let midnightGray = Color(0.1412, 0.1529, 0.1882)
    static let cream = Color(0.9882, 0.9765, 0.9098)
    
#if os(macOS)

    static let lightGray = Color(nsColor: .lightGray)
    static let darkGray = Color(nsColor: .darkGray)

#else

    static let systemGray = Color(uiColor: .systemGray)
    static let systemGray2 = Color(uiColor: .systemGray2)
    static let systemGray3 = Color(uiColor: .systemGray3)
    static let systemGray4 = Color(uiColor: .systemGray4)
    static let systemGray5 = Color(uiColor: .systemGray5)
    static let systemGray6 = Color(uiColor: .systemGray6)

    static let lightGray = Color.systemGray6
    static let darkGray = Color.systemGray

#endif
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
