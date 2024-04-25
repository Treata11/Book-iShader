/*
 Transitions.swift
 Book iShader

 Created by Treata Norouzi on 4/20/24.
 
 Abstract: 
 A ContainerView which showcases the collection of all TransitionViews
*/

import SwiftUI

struct Transitions: View {
    @Bindable private var manager = TransitionManager()
    
    var body: some View {
        NavigationStack {
            ShaderGrid(contents: transitionViews)
                .onHover { hovering in
                    manager.paused = !hovering
                }
        }
        .environment(manager)
    }
}

#Preview("Transitions") { Transitions() }
