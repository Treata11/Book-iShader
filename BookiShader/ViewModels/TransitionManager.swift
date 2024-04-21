/*
 TransitionManager.swift
 Book iShader

 Created by Treata Norouzi on 4/21/24.
 
 Abstract:
 A simple manager for TransitionPreviews which handles the pause/resume of transitions
*/

import Foundation

@Observable
class TransitionManager {
    
    /// The duration of the transition
    @ObservationIgnored var duration: TimeInterval = 1.618
    /// The rest duration between the transitions
    @ObservationIgnored var restDuration: TimeInterval = 1.618 + .ulpOfOne
    
    init(duration: TimeInterval, paused: Bool = true, restDuration: TimeInterval = 1.618 + .ulpOfOne) {
        self.duration = duration
        self.paused = paused
        
        // The restDuration should never be less than the duration of transition
        // or the transitions would stop working in the second attempt
        if restDuration < self.duration {
            self.restDuration = self.duration + .ulpOfOne
        }
    }
    
    /// Variable to keep track of elapsed time
    private(set) var elapsedTime: TimeInterval = 0
    
    var paused = true {
        willSet {
            if !newValue {
                if automationTimer == nil { startTimer() }
            } else {
                pauseTimer()
            }
        }
    }
    
    /**
     Automates the transitions between views with the `restDuration` interval
     */
    private(set) var automationTimer: Timer?
    
    // MARK: - Instance Methods
    
    private func startTimer() {
        self.automationTimer = Timer.scheduledTimer(withTimeInterval: restDuration + .ulpOfOne, repeats: true) { [weak self] timer in
            self?.elapsedTime += timer.timeInterval
        }
    }
    
    func pauseTimer() {
        self.automationTimer?.invalidate()
        automationTimer = nil
    }
}
