/*
 TransitionViews.swift
 BookiShader

 Created by Treata Norouzi on 4/20/24.
 
 Abstract:
 Demonstrating Transition-Shaders in Views
*/

import SwiftUI

let transitionViews: [AnyView] = [
    AnyView(CirclesTransition()), AnyView(SwirlTransition()),
    AnyView(TransitionPreview(transition: .genie())), AnyView(WindTransition()),
    AnyView(TransitionPreview(transition: .radial)), AnyView(CrosswarpTransition()),
    AnyView(TransitionPreview(transition: .dreamy)), AnyView(WindowBlindsTransition()),
    AnyView(MorphTransition())
]

// MARK: - Circles

struct CirclesTransition: View {
    var body: some View {
        TransitionPreview(transition: .circles(size: size))
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    showSettings.toggle()
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.headline)
                        .padding(5)
                        .tint(.secondary)
                })
                .buttonBorderShape(.circle)
                .buttonStyle(.borderless)
                .tint(.accentColor)
            }
            .sheet(isPresented: $showSettings) {
                shaderInputViewBuilder(inputSettings: shaderInput, isPresented: $showSettings)
            }
    }
    
    @State private var showSettings = false
    /// The size of the circles.
    @State private var size: CGFloat = 20
    
    var shaderInput: some View {
        Slider(
            value: $size,
            in: 5...50
        ) {
            Text("Size")
        } minimumValueLabel: {
            Text("5")
        } maximumValueLabel: {
            Text("50")
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview("Circles") { CirclesTransition() }

// MARK: - Swirl

struct SwirlTransition: View {
    var body: some View {
        TransitionPreview(transition: .swirl(radius: radius))
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    showSettings.toggle()
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.headline)
                        .padding(5)
                        .tint(.secondary)
                })
                .buttonBorderShape(.circle)
                .buttonStyle(.borderless)
                .tint(.accentColor)
            }
            .sheet(isPresented: $showSettings) {
                shaderInputViewBuilder(inputSettings: shaderInput, isPresented: $showSettings)
            }
    }
    
    @State private var showSettings = false
    @State private var radius: CGFloat = 0.5
    
    var shaderInput: some View {
        Slider(
            value: $radius,
            in: 0...1
        ) {
            Text("Radius")
        } minimumValueLabel: {
            Text("1")
        } maximumValueLabel: {
            Text("0")
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview("Swirl") { SwirlTransition() }

// MARK: - Genie

#Preview("Genie") { TransitionPreview(transition: .genie()) }

// MARK: - Wind

struct WindTransition: View {
    var body: some View {
        TransitionPreview(transition: .wind(size: size))
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    showSettings.toggle()
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.headline)
                        .padding(5)
                        .tint(.secondary)
                })
                .buttonBorderShape(.circle)
                .buttonStyle(.borderless)
                .tint(.accentColor)
            }
            .sheet(isPresented: $showSettings) {
                shaderInputViewBuilder(inputSettings: shaderInput, isPresented: $showSettings)
            }
    }
    
    @State private var showSettings = false
    @State private var size: CGFloat = 0.1
    
    var shaderInput: some View {
        Slider(
            value: $size,
            in: 0.1...3
        ) {
            Text("Size")
        } minimumValueLabel: {
            Text("0.1")
        } maximumValueLabel: {
            Text("3")
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview("Wind") { WindTransition() }

// MARK: - Radial

#Preview("radial") { TransitionPreview(transition: .radial) }

// MARK: - Crosswarp

struct CrosswarpTransition: View {
    var body: some View {
        TransitionPreview(transition: .crosswarp(rightToLeft: rightToLeft))
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    showSettings.toggle()
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.headline)
                        .padding(5)
                        .tint(.secondary)
                })
                .buttonBorderShape(.circle)
                .buttonStyle(.borderless)
                .tint(.accentColor)
            }
            .sheet(isPresented: $showSettings) {
                shaderInputViewBuilder(inputSettings: shaderInput, isPresented: $showSettings)
            }
    }
    
    @State private var showSettings = false
    @State private var rightToLeft = true
    
    var shaderInput: some View {
        Toggle("Right to Left", isOn: $rightToLeft)
    }
}

#Preview("Crosswarp") { CrosswarpTransition() }

// MARK: - Dreamy

#Preview("Dreamy") { TransitionPreview(transition: .dreamy, duration: 3) }

// MARK: - Window Blinds

struct WindowBlindsTransition: View {
    var body: some View {
        TransitionPreview(transition: .windowBlinds(count: Int(count)))
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    showSettings.toggle()
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.headline)
                        .padding(5)
                        .tint(.secondary)
                })
                .buttonBorderShape(.circle)
                .buttonStyle(.borderless)
                .tint(.accentColor)
            }
            .sheet(isPresented: $showSettings) {
                shaderInputViewBuilder(inputSettings: shaderInput, isPresented: $showSettings)
            }
    }
    
    @State private var showSettings = false
    @State private var count: Float = 80
    
    var shaderInput: some View {
        Slider(
            value: $count,
            in: 10...100
        ) {
            Text("Count")
        } minimumValueLabel: {
            Text("10")
        } maximumValueLabel: {
            Text("100")
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview("Window Blinds") { WindowBlindsTransition() }

// MARK: - Morph

struct MorphTransition: View {
    var body: some View {
        TransitionPreview(transition: .morph(strength: strength))
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    showSettings.toggle()
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.headline)
                        .padding(5)
                        .tint(.secondary)
                })
                .buttonBorderShape(.circle)
                .buttonStyle(.borderless)
                .tint(.accentColor)
            }
            .sheet(isPresented: $showSettings) {
                shaderInputViewBuilder(inputSettings: shaderInput, isPresented: $showSettings)
            }
    }
    
    @State private var showSettings = false
    @State private var strength: Float = 0.1
    
    var shaderInput: some View {
        Slider(
            value: $strength,
            in: 0.01...1
        ) {
            Text("strength")
        } minimumValueLabel: {
            Text("0.01")
        } maximumValueLabel: {
            Text("1")
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview("Morph") { MorphTransition() }
