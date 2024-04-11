/*
 ShaderArtViews.swift
 Book iShader

 Created by Treata Norouzi on 4/2/24.
 
 Abstract:
 
*/

import SwiftUI
import ShaderArt

/**
 A `Collection` of all the sample Views created using the `iShader`'s ShaderArt target.
 */
let shaderArtViews: [AnyView] = [
    AnyView(HypnoticRipplesView()), AnyView(CrystalCausticView()), 
    AnyView(BeamDropletView()), AnyView(SineWavesView()),
    AnyView(PortalView()), AnyView(NeonRugView()),
    AnyView(StarNestView()), AnyView(BlueVoidView()), 
    AnyView(SpiralRidersView()), AnyView(BlackHoleDawnView()),
    AnyView(CosmicBloodView()), AnyView(PulsatingFleshView()),
    AnyView(WritheView()), AnyView(CloudsView()),
    AnyView(BaseWarpView()), AnyView(LensFlareView()),
    AnyView(IrisView()), AnyView(TurbulenceView()),
    AnyView(LavaBlobsView()), AnyView(TMGyroidsView()),
    AnyView(FireWorksView()), AnyView(ExplosionCloudView()),
    AnyView(ModFanView()), AnyView(StarFieldView()),
    AnyView(SingularityView()), AnyView(GlowingMarblingBlackView()),
    AnyView(ElectricFieldView()), AnyView(FBMLightningView()),
    AnyView(WetNeuralNetworkView()), AnyView(Lightning01View())
]

/*
 FIXME: @State private var hud.startTime = Date.now
 .now is being problematic ...
    let hud.elapsedTime = hud.startTime.distance(to: context.date)
 
 The distance to .now would be extended even when the shader is paused.
 So, you'll never pause the shader at a given time ...
 */

// MARK: - Hypnotic Ripples

struct HypnoticRipplesView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        HypnoticRipples(time: hud.elapsedTime)
    }
}

#Preview("Hypnotic Ripples") { HypnoticRipplesView().enhancedPreview() }

// MARK: - Crystal Caustic

struct CrystalCausticView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        CrystalCaustic(time: hud.elapsedTime)
    }
}

#Preview("Crystal Caustic") { CrystalCausticView().enhancedPreview() }

// MARK: - Beam Droplet

struct BeamDropletView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        BeamDroplet(time: hud.elapsedTime)
    }
}

#Preview("Beam Droplet") { BeamDropletView().enhancedPreview() }

// MARK: - Sine Waves

struct SineWavesView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var relativeColor = Color(0.2, 0.2, 0.3)
    @State private var waveCount = 7

    var body: some View {
        SineWaves(relativeColor: relativeColor, time: hud.elapsedTime, waveCount: waveCount)
        // The input settings
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
    let range: ClosedRange<Int> = 3...13
    
    var shaderInput: some View {
        Group {
            ColorPicker("Relative Wave Color", selection: $relativeColor)
            
            Picker("Count of Waves", selection: $waveCount) {
                ForEach(range, id: \.self) { timeIncrement in
                    HStack {
                        // Forces the text in the Picker to be right-aligned
                        Spacer()
                        Text("\(timeIncrement)")
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview("Sine Waves") { SineWavesView().enhancedPreview() }

// MARK: - Portal

struct PortalView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        Portal(time: hud.elapsedTime)
    }
}

#Preview("Portal") { PortalView().enhancedPreview() }

// MARK: - Neon Rug

struct NeonRugView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        NeonRug(time: hud.elapsedTime, neonEffect: neonEffect)
        // The input settings
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
    @State private var neonEffect = true
    
    var shaderInput: some View {
        Toggle("Neon Effect", isOn: $neonEffect)
            .padding(.horizontal)
            .padding(.vertical, 5)
    }
}

#Preview("NeonRug") { NeonRugView().enhancedPreview() }

// MARK: - Star Nest

struct StarNestView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var touch: CGPoint = .zero

    var body: some View {
        StarNest(time: hud.elapsedTime, location: touch)
        .gesture(
            DragGesture()
                .onChanged { self.touch = $0.location }
        )
    }
}

#Preview("Star Nest") { StarNestView().enhancedPreview() }

// MARK: - Blue Void

struct BlueVoidView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var touch: CGPoint = .zero

    var body: some View {
        BlueVoid(time: hud.elapsedTime, location: touch)
        .gesture(
            DragGesture()
                .onChanged { value in
                    let location = CGPoint(x: value.location.x/333, y: value.location.y/333)
                    self.touch = location
                }
        )
    }
}

#Preview("Blue Void") { BlueVoidView().enhancedPreview() }

// MARK: - Spiral Riders

struct SpiralRidersView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        SpiralRiders(time: hud.elapsedTime)
    }
}

#Preview("Spiral Riders") { SpiralRidersView().enhancedPreview() }

// MARK: - Black Hole Dawn

struct BlackHoleDawnView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        BlackHoleDawn(relativeColor: relativeColor, time: hud.elapsedTime)
        // The input settings
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
    /// Means that the result color in the shader, might not precisely match the given color.
    @State private var relativeColor = Color(1, 0.025, 0)
    
    var shaderInput: some View {
        ColorPicker("Relative Color", selection: $relativeColor)
            .padding(.horizontal)
            .padding(.vertical, 5)
    }
}

#Preview("Black Hole Dawn") { BlackHoleDawnView().enhancedPreview() }

// MARK: - Cosmic Blood

struct CosmicBloodView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        CosmicBlood(time: hud.elapsedTime)
    }
}

#Preview("Cosmic Blood") { CosmicBloodView().enhancedPreview() }

// MARK: - Pulsating Flesh

struct PulsatingFleshView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var touch: CGPoint = .zero

    var body: some View {
        PulsatingFlesh(time: hud.elapsedTime, location: touch)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { self.touch = $0.location }
        )
    }
}

#Preview("Pulsating Flesh") { PulsatingFleshView().enhancedPreview() }

// MARK: - Writhe

struct WritheView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var touchLocation: CGPoint = .zero
    
    var body: some View {
        Writhe(time: hud.elapsedTime, location: touchLocation)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { self.touchLocation = $0.location }
        )
    }
}

#Preview("Writhe") { WritheView().enhancedPreview() }

// MARK: - Clouds

struct CloudsView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    @State private var cloudScale: Float = 1.1
    @State private var cloudAlpha: Float = 8
    @State private var windSpeed: Float = 0.03
    
    var body: some View {
        Clouds(time: hud.elapsedTime,
               cloudScale: cloudScale,
               cloudAlpha: cloudAlpha,
               windSpeed: windSpeed
        )
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
    
    var shaderInput: some View {
        // Sliders
        Group {
            Slider(
                value: $cloudScale,
                in: 0.7...5
            ) {
                Text("Cloud Scale")
            } minimumValueLabel: {
                Text("0.7")
            } maximumValueLabel: {
                Text("5")
            }
            
            Slider(
                value: $cloudAlpha,
                in: 1...10
            ) {
                Text("Cloud Alpha")
            } minimumValueLabel: {
                Text("1")
            } maximumValueLabel: {
                Text("10")
            }
            
            Slider(
                value: $windSpeed,
                in: 0.01...0.09
            ) {
                Text("Wind Speed")
            } minimumValueLabel: {
                Text("0.01")
            } maximumValueLabel: {
                Text("0.09")
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview("Clouds") { CloudsView().enhancedPreview() }

// MARK: - Base Warp

struct BaseWarpView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    @State private var translation: CGPoint = .zero

    var body: some View {
        BaseWarp(time: hud.elapsedTime, location: translation)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        self.translation = value.location
                    }
            )
            .background(Color.black)
    }
}

#Preview("Base Warp") { BaseWarpView().enhancedPreview() }

// MARK: - Lens Flare

struct LensFlareView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    @State private var location: CGPoint = .zero

    var body: some View {
        LensFlare(time: hud.elapsedTime, location: location)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { self.location = $0.location }
            )
    }
}

#Preview("LensFlareView") { LensFlareView().enhancedPreview() }

// MARK: - Iris

struct IrisView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        Iris(irisColor: irisColor, time: hud.elapsedTime, corneaEdgeHue: corneaEdgeHue)
        // The input settings
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
    
    @State private var irisColor = Color(0, 0.3, 0.4)
    @State private var corneaEdgeHue: Color = .init(0.9, 0.6, 0.2)
    
    var shaderInput: some View {
        Group {
            ColorPicker("Iris Color", selection: $irisColor)
            ColorPicker("Cornea Edge Hue", selection: $corneaEdgeHue)
        }
            .padding(.horizontal)
            .padding(.vertical, 5)
    }
}

#Preview("Iris") { IrisView().enhancedPreview() }

// MARK: - Retro Sun

struct RetroSunView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        RetroSun(time: hud.elapsedTime)
    }
}

#Preview("Retro Sun") { RetroSunView().enhancedPreview() }

// MARK: - Turbulence

struct TurbulenceView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var touch: CGPoint = .zero

    var body: some View {
        Turbulence(time: hud.elapsedTime, location: touch)
        .background(Color.black)
        .gesture(
            DragGesture()
                .onChanged { self.touch = $0.location }
        )
    }
}

#Preview("Turbulence") { TurbulenceView().enhancedPreview() }

// MARK: - Lava Blobs

struct LavaBlobsView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        LavaBlobs(time: hud.elapsedTime)
            .background(Color.black)
    }
}

#Preview("Lava Blobs") { LavaBlobsView().enhancedPreview() }

// MARK: - TM Gyroids

struct TMGyroidsView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        TMGyroids(time: hud.elapsedTime)
    }
}

#Preview("TM Gyroids") { TMGyroidsView().enhancedPreview() }

// MARK: - Fire Works

struct FireWorksView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        FireWorks(time: hud.elapsedTime)
    }
}

#Preview("Fire Works") { FireWorksView().enhancedPreview() }

// MARK: - Explosion Cloud

struct ExplosionCloudView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        ExplosionCloud(time: hud.elapsedTime)
    }
}

#Preview("Explosion Cloud") { ExplosionCloudView().enhancedPreview() }

// MARK: - Mod Fan

struct ModFanView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
            ModFan(time: hud.elapsedTime)
    }
}

#Preview("Mod Fan") { ModFanView().enhancedPreview() }

// MARK: - Star Field

struct StarFieldView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        StarField(time: hud.elapsedTime)
    }
}

#Preview("Star Field") { StarFieldView().enhancedPreview() }

// MARK: - Singularity

struct SingularityView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        Singularity(time: hud.elapsedTime)
    }
}

#Preview("Singularity") { SingularityView().enhancedPreview() }

// MARK: - Glowing Marbling Black

// FIXME: Fix the gestures
struct GlowingMarblingBlackView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var touch: CGPoint = .zero

    var body: some View {
        GlowingMarblingBlack(time: hud.elapsedTime, location: touch)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let translatedValue = CGPoint(x: (value.location.x/100), y: (value.location.y/100))
                        self.touch = translatedValue
                    }
            )
    }
}

#Preview("Glowing Marbling Black") { GlowingMarblingBlackView().enhancedPreview() }

// MARK: - Electric Field

struct ElectricFieldView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        ElectricField(time: hud.elapsedTime)
    }
}

#Preview("Electric Field") { ElectricFieldView().enhancedPreview() }

// MARK: - FBM Lightning

struct FBMLightningView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud

    var body: some View {
        FBMLightning(lightningColor: lightningColor, time: hud.elapsedTime)
        // The input settings
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
    
    @State private var lightningColor = Color(0.2, 0.3, 0.8)
    
    var shaderInput: some View {
        ColorPicker("Lightning Color", selection: $lightningColor)
            .padding(.horizontal)
            .padding(.vertical, 5)
    }
}

#Preview("FBM Lightning") { FBMLightningView().enhancedPreview() }

// MARK: - Wet Neural Network

struct WetNeuralNetworkView: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var touch: CGPoint = .zero

    var body: some View {
        WetNeuralNetwork(color: color, time: hud.elapsedTime, location: touch)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { self.touch = $0.location }
            )
        // The input settings
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
    
    @State private var color = Color(0.25, 0.5, 1)
    
    var shaderInput: some View {
        ColorPicker("Color", selection: $color)
            .padding(.horizontal)
            .padding(.vertical, 5)
    }
}

#Preview("Wet Neural Network") { WetNeuralNetworkView().enhancedPreview() }

// MARK: - Lightning01

struct Lightning01View: View {
    @Environment(ShaderHud.self) var hud: ShaderHud
    
    @State private var touch: CGPoint = .zero

    var body: some View {
            Lightning01(lightningColor: lightningColor, time: hud.elapsedTime, location: touch)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    let location = CGPoint(x: value.location.x/500, y: value.location.y/500)
                    self.touch = location
                }
        )
        // The input settings
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
    
    @State private var lightningColor: Color = .init(1.2, 0.2, 0.3)
    
    var shaderInput: some View {
        ColorPicker("Lightning Color", selection: $lightningColor)
            .padding(.horizontal)
            .padding(.vertical, 5)
    }
}

#Preview("Lightning01") { Lightning01View().enhancedPreview() }
