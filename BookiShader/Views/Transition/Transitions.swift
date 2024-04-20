/*
 Transitions.swift
 Book iShader

 Created by Treata Norouzi on 4/20/24.
 
 Abstract: 
 A ContainerView which showcases the collection of all TransitionViews
*/

import SwiftUI

struct Transitions: View {
    var body: some View {
        NavigationStack {
            ShaderGrid(contents: transitionViews)
        }
    }
}

#Preview("") { Transitions() }
