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
    @Bindable var manager = TransitionManager()
    
    /// The transition which is called from a shader function
    var transition: AnyTransition
    
    init(transition: AnyTransition) { self.transition = transition }
    
    /// Whether we're showing the first view or the second view.
    @State private var showingFirstView = true
    
    var body: some View {
        Group {
            if showingFirstView {
                firstView
                    .transition(transition)

            } else {
                secondView
                    .transition(transition)
            }
        }
        // Triggering the start of transition on macOS & visionOS
        .onHover { hovering in
            print("TransitionPreview; hovering: \(hovering)")
            triggerTimer(!hovering)
        }
        .contextMenu {
            // TODO: STH more useful, maybe name of the transition ...
            Text("Preview")
                .onAppear { triggerTimer(true) }
                .onDisappear { triggerTimer(false) }
        }
        // automatically transitions back & forth between the views with a slight rest
        .onChange(of: manager.elapsedTime) {
            // Handle the transition anmation here
            withAnimation(.easeIn(duration: manager.duration)) {
                showingFirstView.toggle()
            }
        }
        .onTapGesture {
            print(manager.elapsedTime)
        }
        // Debug
        .onChange(of: manager.paused) {
            print("TransitionPreview; manager isPaused: \(manager.paused)")
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
    
    // MARK: VM Intents
    
    func triggerTimer(_ value: Bool) {
        print("TransitionPreview; triggerTimer()")
        manager.paused = value
    }
}

#Preview("Transition Preview") { TransitionPreview(transition: .dreamy) }

#Preview("Transitions") {
    Grid() {
        TransitionPreview(transition: .swirl())
        TransitionPreview(transition: .crosswarp())
    }
}
