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
}
//5 + 15-paused
