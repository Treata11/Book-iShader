/*
 TransitionPreview.swift
 Book iShader

 Created by Treata Norouzi on 4/17/24.
 
 Abstract:
 A simple template to for previewing transitions
*/

import Transition
import SwiftUI

// TODO: New File
let imageResources: [ImageResource] = [
    .darakehTehran, .pufferFishShader, .road59Chalus, .mountDamavand
]

// !!!: Currently the most suitable devices to view this are macOS & visionOS
// No onHovering exists in iOS & tvOS

struct TransitionPreview: View {
    /// The transition which is called from a shader function
    var transition: AnyTransition
    
    /// The duration of the transition
    var duration: TimeInterval = 1.618 / 1.03
    /// The rest duration between the transitions
    var restDuration: TimeInterval = 1.618 * 1.03
    
    init(
        transition: AnyTransition,
        transitionDuration: TimeInterval = 1.618 / 1.03,
        restDuration: TimeInterval = 1.618 * 1.03
    ) {
        self.transition = transition
        
        self.duration = transitionDuration
        self.restDuration = restDuration
        
        // The restDuration should always be atleast 5_10% longer than the transitionDuration
        // or the transitions would stop working
        let smallPause = self.duration * 1.05
        if restDuration < smallPause {
            self.restDuration = smallPause
            print("TransitionManager; Adjusted restDuration")
        }
        
        imageRandomizer()
    }
    
    /// Whether we're showing the first view or the second view.
    @State private var showingFirstView = true
    
    // Timeline related
    @State private var paused = true
    @State private var startTime = Date.now
    
    var body: some View {
        TimelineView(.animation(minimumInterval: restDuration, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            transitionViews
            // automatically transitions back & forth between the views with a slight rest
            .onChange(of: elapsedTime) {
                withAnimation(.linear(duration: duration)) {
                    showingFirstView.toggle()
                }
            }
        }
        // Triggering the start of transition on macOS & visionOS
        .onHover { hovering in
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
    
    private var firstImage: ImageResource = .road59Chalus
    
    var firstView: some View {
        Image(firstImage)
            .resizable()
            .aspectRatio(4/3, contentMode: .fit)
    }
    
    private var secondImage: ImageResource = .mountDamavand
    
    var secondView: some View {
        Image(secondImage)
            .resizable()
            .aspectRatio(4/3, contentMode: .fit)
    }
    
    // MARK: - Instance methods
    
    /// Image Randomizer
    private mutating func imageRandomizer() {
        var images = imageResources
        // removing PufferFish Image
        images.remove(at: images.firstIndex(of: .pufferFishShader)!)
        
        let randomImage = images.randomElement()!
        // removing the selected random image
        images.remove(at: images.firstIndex(of: randomImage)!)
        
        self.firstImage = randomImage
        self.secondImage = images.randomElement()!
    }
}

#Preview("Transition Preview") { TransitionPreview(transition: .dreamy) }

#Preview("Transitions") {
    Grid() {
        TransitionPreview(transition: .swirl())
        TransitionPreview(transition: .crosswarp())
    }
}
