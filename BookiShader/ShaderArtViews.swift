/*
 ShaderArtViews.swift
 Book iShader

 Created by Treata Norouzi on 4/2/24.
 
 Abstract:
 
*/

import SwiftUI
import ShaderArt

/*
 FIXME: @State private var startTime = Date.now
 .now is being problematic ...
    let elapsedTime = startTime.distance(to: context.date)
 
 The distance to .now would be extended even when the shader is paused.
 So, you'll never pause the shader at a given time ...
 */

// MARK: - Hypnotic Ripples

struct HypnoticRipplesView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            HypnoticRipples(time: elapsedTime)
        }
        .ignoresSafeArea()
    }
}

#Preview("Hypnotic Ripples") { HypnoticRipplesView() }

// MARK: - Crystal Caustic

struct CrystalCausticView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.017, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            CrystalCaustic(time: elapsedTime)
        }
        .ignoresSafeArea()
    }
}

#Preview("Crystal Caustic") { CrystalCausticView() }

// MARK: - Beam Droplet

struct BeamDropletView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            BeamDroplet(time: elapsedTime)
        }
        .ignoresSafeArea()
    }
}

#Preview("Beam Droplet") { BeamDropletView() }

// MARK: - Sine Waves

struct SineWavesView: View {
    @State var paused = false
    
    var relativeColor = Color(red: 0.2, green: 0.2, blue: 0.3)
    var waveCount = 7
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.0167, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            SineWaves(relativeColor: relativeColor, time: elapsedTime, waveCount: waveCount)
        }
        .ignoresSafeArea()
    }
}

#Preview("Sine Waves") { SineWavesView() }

// MARK: - Portal

struct PortalView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            Portal(time: elapsedTime)
        }
        .ignoresSafeArea()
    }
}

#Preview("Portal") { PortalView() }

// MARK: - Neon Rug

struct NeonRugView: View {
    @State var paused = false
    
    var neonEffect = true
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            NeonRug(time: elapsedTime, neonEffect: neonEffect)
        }
        .ignoresSafeArea()
    }
}

#Preview("NeonRug") { NeonRugView() }

// MARK: - Star Nest

struct StarNestView: View {
    @State var paused = false
    
    @State private var startTime = Date.now
    
    @State private var translation: CGPoint = .zero

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.05, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            StarNest(time: elapsedTime * 0.5, location: translation)
        }
        .ignoresSafeArea()
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.translation = value.location
                }
        )
    }
}

#Preview("Star Nest") { StarNestView() }

// MARK: - Blue Void

struct BlueVoidView: View {
    @State var paused = false
    
    @State private var startTime = Date.now
    
    @State private var touch: CGPoint = .zero

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.0167, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            BlueVoid(time: elapsedTime, location: touch)
        }
        .ignoresSafeArea()
        .gesture(
            DragGesture()
                .onChanged { value in
                    let location = CGPoint(x: value.location.x/333, y: value.location.y/333)
                    self.touch = location
                }
        )
    }
}

#Preview("Blue Void") { BlueVoidView() }

// MARK: - Spiral Riders

struct SpiralRidersView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.09, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            SpiralRiders(time: elapsedTime * 0.8)
        }
        .ignoresSafeArea()
    }
}

#Preview("Spiral Riders") { SpiralRidersView() }

// MARK: - Black Hole Dawn

struct BlackHoleDawnView: View {
    @State @State var paused = false
    
    /// Means that the result color in the shader, might not precisely match the given color.
    var relativeColor = Color(red: 1, green: 0.025, blue: 0)
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.05, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            BlackHoleDawn(relativeColor: relativeColor, time: elapsedTime*0.03)
        }
        .ignoresSafeArea()
    }
}

#Preview("Black Hole Dawn") { BlackHoleDawnView() }

// MARK: - Cosmic Blood

struct CosmicBloodView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.03, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            CosmicBlood(time: elapsedTime * 0.04)
        }
        .ignoresSafeArea()
    }
}

#Preview("Cosmic Blood") { CosmicBloodView() }

// MARK: - Pulsating Flesh

struct PulsatingFleshView: View {
    @State var paused = false
    
    @State private var startTime = Date.now
    @State private var touch: CGPoint = .zero

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.03, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            PulsatingFlesh(time: elapsedTime, location: touch)
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { self.touch = $0.location }
        )
    }
}

// MARK: - Writhe

#Preview("Pulsating Flesh") { PulsatingFleshView() }

struct WritheView: View {
    @State var paused = false
    
    @State private var startTime = Date.now
    @State private var touchLocation: CGPoint = .zero
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            Writhe(time: elapsedTime, location: touchLocation)
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { self.touchLocation = $0.location }
        )
    }
}

#Preview("Writhe") { WritheView() }

// MARK: - Clouds

struct CloudsView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.03, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            Clouds(time: elapsedTime)
        }
        .ignoresSafeArea()
    }
}

#Preview("Clouds") { CloudsView() }

// MARK: - Base Warp

struct BaseWarpView: View {
    @State var paused = false
    
    @State private var startTime = Date.now
    @State private var translation: CGPoint = .zero

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.05, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            BaseWarp(time: elapsedTime, location: translation)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            self.translation = value.location
                        }
                )
        }
        .ignoresSafeArea()
        .background(Color.black)
    }
}

#Preview("Base Warp") { BaseWarpView() }

// MARK: - Lens Flare

struct LensFlareView: View {
    @State var paused = false
    
    @State private var startTime = Date.now
    @State private var location: CGPoint = .zero

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.08, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            LensFlare(time: elapsedTime*0.5, location: location)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            self.location = value.location
                        }
                )
        }
        .ignoresSafeArea()
    }
}

#Preview("LensFlareView") { LensFlareView() }

// MARK: - Iris

struct IrisView: View {
    @State var paused = false
    
    var irisColor = Color(red: 0, green: 0.3, blue: 0.4)
    var corneaEdgeHue: Color = .init(red: 0.9, green: 0.6, blue: 0.2)
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.05, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            Iris(irisColor: irisColor, time: elapsedTime, corneaEdgeHue: corneaEdgeHue)
        }
        .ignoresSafeArea()
    }
}

#Preview("Iris") { IrisView() }

// MARK: - Retro Sun

struct RetroSunView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.1, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            RetroSun(time: elapsedTime)
        }
        .ignoresSafeArea()
    }
}

#Preview("Retro Sun") { RetroSunView() }

// MARK: - Turbulence

struct TurbulenceView: View {
    @State var paused = false
    
    @State private var startTime = Date.now
    
    @State private var touch: CGPoint = .zero

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.017, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            Turbulence(time: elapsedTime, location: touch)
        }
        .ignoresSafeArea()
        .background(Color.black)
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.touch = value.location
                }
        )
    }
}

#Preview("Turbulence") { TurbulenceView() }

// MARK: - Lava Blobs

struct LavaBlobsView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.05, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            LavaBlobs(time: elapsedTime)
        }
        .ignoresSafeArea()
        .background(Color.black)
    }
}

#Preview("Lava Blobs") { LavaBlobsView() }

// MARK: - TM Gyroids

struct TMGyroidsView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.018, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            TMGyroids(time: elapsedTime)
        }
        .ignoresSafeArea()
    }
}

#Preview("TM Gyroids") { TMGyroidsView() }

// MARK: - Fire Works

struct FireWorksView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            FireWorks(time: elapsedTime)
        }
        .ignoresSafeArea()
    }
}

#Preview("Fire Works") { FireWorksView() }

// MARK: - Explosion Cloud

struct ExplosionCloudView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.03, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            ExplosionCloud(time: elapsedTime)
        }
        .ignoresSafeArea()
    }
}

#Preview("Explosion Cloud") { ExplosionCloudView() }

// MARK: - Mod Fan

struct ModFanView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.05, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            ModFan(time: elapsedTime*0.2)
        }
        .ignoresSafeArea()
    }
}

#Preview("Mod Fan") { ModFanView() }

// MARK: - Star Field

struct StarFieldView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.025, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            StarField(time: elapsedTime)
        }
        .ignoresSafeArea()
    }
}

#Preview("Star Field") { StarFieldView() }

// MARK: - Singularity

struct SingularityView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.025, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            Singularity(time: elapsedTime)
        }
        .ignoresSafeArea()
    }
}

#Preview("Singularity") { SingularityView() }

// MARK: - Glowing Marbling Black

// FIXME: Fix the gestures
struct GlowingMarblingBlackView: View {
    @State var paused = false
    
    @State private var startTime = Date.now
    
    @State private var touch: CGPoint = .zero

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.03, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            GlowingMarblingBlack(time: elapsedTime*0.5, location: touch)
        }
        .ignoresSafeArea()
//        .gesture(
//            DragGesture(minimumDistance: 0)
//                .onChanged { value in
//                    let translatedValue = CGSize(width: value.translation.width/175, height: value.translation.height/175).mapZeroToOne()
//                    self.touch = translatedValue
//                }
//        )
    }
}

#Preview("Glowing Marbling Black") { GlowingMarblingBlackView() }

// MARK: - Electric Field

struct ElectricFieldView: View {
    @State var paused = false
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.02, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            ElectricField(time: elapsedTime)
        }
        .ignoresSafeArea()
    }
}

#Preview("Electric Field") { ElectricFieldView() }

// MARK: - FBM Lightning

struct FBMLightningView: View {
    @State var paused = false
    
    var lightningColor = Color(red: 0.2, green: 0.3, blue: 0.8)
    
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.0167, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            FBMLightning(lightningColor: lightningColor, time: elapsedTime)
        }
        .ignoresSafeArea()
    }
}

#Preview("FBM Lightning") { FBMLightningView() }

// MARK: - Wet Neural Network

struct WetNeuralNetworkView: View {
    @State var paused = false
    
    var color = Color(red: 0.25, green: 0.5, blue: 1)

    @State private var startTime = Date.now
    @State private var touch: CGPoint = .zero

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.0167, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date + 700)
            
            WetNeuralNetwork(color: color, time: elapsedTime, location: touch)
        }
        .ignoresSafeArea()
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    self.touch = value.location
                }
        )
    }
}

#Preview("Wet Neural Network") { WetNeuralNetworkView() }

// MARK: - Lightning01

struct Lightning01View: View {
    @State var paused = false
    
    var lightningColor: Color = .init(red: 1.2, green: 0.2, blue: 0.3)
    
    @State private var startTime = Date.now
    @State private var touch: CGPoint = .zero

    var body: some View {
        TimelineView(.animation(minimumInterval: 0.025, paused: paused)) { context in
            let elapsedTime = startTime.distance(to: context.date)
            
            Lightning01(lightningColor: lightningColor, time: elapsedTime, location: touch)
        }
        .ignoresSafeArea()
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    let location = CGPoint(x: value.location.x/500, y: value.location.y/500)
                    self.touch = location
                }
        )
    }
}

#Preview("Lightning01") { Lightning01View() }
