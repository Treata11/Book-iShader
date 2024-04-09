/*
 ShaderHud.swift
 Book iShader

 Created by Treata Norouzi on 4/5/24.
 
 Abstarct:
 A WIP VM which would create a video-like HUD-model for shaders in order to play/pause
 rewind/fast-forwad the Shaders
*/

import Foundation

// !!!: WIP

/*
 # Archived
 
 This version of ShaderHud, would no longer be used, since all the implementations
 of the timer are now moved to the ViewModel itself and the SwiftUI's TimeLineView
 is no longer used!
*/

@Observable
class ShaderHud {
    
    private(set) var startTime: Date = .now
    private(set) var pausedDate: Date = .now
    
    /**
     If the schedule should stop generating updates.
     */
    var paused: Bool = true {
        willSet {
            if newValue {
                // Preserving the precise Date that the TimeLine is paused at
                self.pausedDate = .now
            } else {
                /*
                 The time between the moment when TimeLine is paused and the time
                 it is resumed once more is added to the initial startTime property
                 
                 This is necessary, because the argument of TimeLineView `contex`
                 is a date & it always return now!
                 This would be a problem when TimeLine is unpaused; context
                 would simply return now and doesn't substract the elapsed time
                 between pause & resume automatically, hence we had to to do it here
                 in our model.
                 */
                startTime.addTimeInterval(pausedDate.distance(to: .now))
                print("\(-Date.now.distance(to: pausedDate))")
            }
        }
    }
    
    // MARK: - Intent(s)
    
    func rewind(seconds: TimeInterval) { startTime = startTime.addingTimeInterval(seconds) }
    
    func fastForward(seconds: TimeInterval) { startTime = startTime.addingTimeInterval(-seconds) }
}




// MARK: - Experimental: Timer Tests

// TODO: Rename to ShaderHud & rewrite the Views that are using the previous implementation of ShaderHud.
// That means that TimeLineView would no longer be needed.

@Observable
class ShaderManager {
    
    var fps: Float = 60
    
    /// The rate of the playback, `Playback Speed`
    var rate: PlaybackSpeed = .one
    
    init(fps: Float = 60, rate: PlaybackSpeed = .one, paused: Bool = true) {
        self.fps = fps
        self.rate = rate
        self.paused = paused
    }
    
    var paused = true {
        willSet {
            if !newValue {
                if stopwatchTimer == nil {
                    startTimer()
                }
            } else {
                pauseTimer()
            }
        }
    }
    
    /// Timer object to track elapsed time
    private(set) var stopwatchTimer: Timer?
    
    /// Variable to keep track of elapsed time
    private(set) var elapsedTime: TimeInterval = 0
    
    // MARK: - Instance Methods
    
    private func startTimer() {
        self.stopwatchTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1.0/fps), repeats: true, block: { [weak self] timer in
            // Update the elapsed time
            self?.elapsedTime += timer.timeInterval * (self?.rate ?? .one).rawValue
        })
    }
    
    func pauseTimer() {
        self.stopwatchTimer?.invalidate()
        stopwatchTimer = nil
    }
    
    func stopTimer() {
        if let timer = stopwatchTimer {
            paused = true
            timer.invalidate()
            stopwatchTimer = nil
            elapsedTime = 0
        }
    }
    
    func toggleTimer() { self.paused.toggle() }
    
    func formattedElapsedTime() -> String {
        // Format the elapsed time as a stopwatch time
        let minutes = Int(elapsedTime) / 60 % 60
        let seconds = Int(elapsedTime) % 60
        let milliseconds = Int(elapsedTime * 100) % 100
        
        // Return the formatted time
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }
}

enum PlaybackSpeed: Double, CaseIterable, Identifiable {
    case pointOne = 0.1
    case pointTwo = 0.2
    case pointTwentyFive = 0.25
    case pointThree = 0.3
    case pointFour = 0.4
    case pointFive = 0.5
    case pointSix = 0.6
    case pointSeven = 0.7
    case pointEight = 0.8
    case pointNine = 0.9
    case one = 1.0
    case onePointTwoFive = 1.25
    case onePointFive = 1.5
    case onePointSevenFive = 1.75
    case two = 2.0
    case twoPointTwoFive = 2.25
    case twoPointFive = 2.5
    case twoPointSevenFive = 2.75
    case three = 3.0

    var id: Double { self.rawValue }
}
