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
    
    init(transition: AnyTransition) { self.transition = transition }
    
    /// Whether we're showing the first view or the second view.
    @State private var showingFirstView = true
    
    // Timeline related
    @State private var paused = true
    @State private var startTime = Date.now
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 1.618 * 1.05, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            transitionViews
            // automatically transitions back & forth between the views with a slight rest
            .onChange(of: elapsedTime) {
                withAnimation(.linear(duration: 1.618 / 1.05)) {
                    showingFirstView.toggle()
                }
            }
        }
        // Triggering the start of transition on macOS & visionOS
        .onHover { hovering in
            print("TransitionPreview; hovering: \(hovering)")
            paused = !hovering
        }
        // Intended for devices that there's no hovering action (iOS, tvOS)
        // It's full of bugs ...
        .contextMenu(menuItems: {
            // TODO: STH more useful, maybe name of the transition ...
            Text("Preview")
            
            Button(action: {
                paused.toggle()
            }, label: {
                paused ? Image(systemName: "play.fill") : Image(systemName: "pause.fill")
            })
            .font(.title)
            .buttonBorderShape(.circle)
            .padding()
        })
    }
    
    // MARK: Images
    
    var transitionViews: some View {
        Group {
            if showingFirstView {
                firstView
                    .transition(transition)
                
            } else {
                secondView
                    .transition(transition)
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

#Preview("Transition Preview") { TransitionPreview(transition: .dreamy) }

#Preview("Transitions") {
    Grid() {
        TransitionPreview(transition: .swirl())
        TransitionPreview(transition: .crosswarp())
    }
}
