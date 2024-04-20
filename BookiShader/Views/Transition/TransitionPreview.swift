/*
 TransitionPreview.swift
 Book iShader

 Created by Treata Norouzi on 4/17/24.
 
 Abstract:
 A simple template to for previewing transitions
*/

import Transition
import SwiftUI

struct TransitionPreview: View {
    /// The transition which is called from a shader function
    var transition: AnyTransition
    /// The duration of the transition
    var duration: TimeInterval = 1.618
    
    init(transition: AnyTransition, duration: TimeInterval = 1.618) {
        self.transition = transition
        self.duration = duration
    }
    
    /// Whether we're showing the first view or the second view.
    @State private var showingFirstView = true
    
    var body: some View {
        VStack {
            if showingFirstView {
                firstView
                    .transition(transition)

            } else {
                secondView
                    .transition(transition)
            }
            
            // TODO: Instead of the button, use a Timeline view which automatically transitions back & forth between the views with a slight rest
            Button("Toggle Views") {
                withAnimation(.easeIn(duration: duration)) {
                    showingFirstView.toggle()
                }
            }
        }
    }
    
    var firstView: some View {
        Image(.road59Chalus)
            .resizable()
            .aspectRatio(4/3, contentMode: .fit)
    }
    
    var secondView: some View {
        Image(.darakehTehran)
            .resizable()
            .aspectRatio(4/3, contentMode: .fit)
    }
}
