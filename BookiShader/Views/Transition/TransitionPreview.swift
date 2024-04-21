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
    @Environment(TransitionManager.self) private var manager
    
    /// The transition which is called from a shader function
    var transition: AnyTransition
    
    init(transition: AnyTransition) {
        self.transition = transition
    }
    
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
        // automatically transitions back & forth between the views with a slight rest
        .onChange(of: manager.elapsedTime) {
            // Handle the transition anmation here
            withAnimation(.easeIn(duration: manager.duration)) {
                showingFirstView.toggle()
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

#Preview("TransitionPreview") { TransitionPreview(transition: .dreamy).environment(TransitionManager()) }

// MARK: - False Approach - Without relying on a VM

/*
struct TransitionPreview: View {
    /// The transition which is called from a shader function
    var transition: AnyTransition
    /// The duration of the transition
    @State var duration: TimeInterval = 1.618
    
    init(transition: AnyTransition, duration: TimeInterval = 1.618) {
        self.transition = transition
        self.duration = duration
        
        self.timer = Timer.publish(every: duration * 2 + .ulpOfOne, on: .main, in: .common).autoconnect()
    }
    
    /// Whether we're showing the first view or the second view.
    @State private var showingFirstView = true

    // Timer publisher to trigger the toggle
    @State private var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    var body: some View {
        VStack {
            if showingFirstView {
                firstView
                    .transition(transition)

            } else {
                secondView
                    .transition(transition)
            }
        }
        .onReceive(timer) { _ in
            // Toggle the view automatically
            withAnimation(.easeIn(duration: duration)) {
                showingFirstView.toggle()
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
    
    private func setTimer(active: Bool = true) -> Publishers.Autoconnect<Timer.TimerPublisher>? {
        Timer.publish(every: duration * 2 + .ulpOfOne, on: .main, in: .common).autoconnect()
    }
}
*/
