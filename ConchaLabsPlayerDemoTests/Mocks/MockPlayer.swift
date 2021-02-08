//
//  MockPlayer.swift
//  ConchaLabsPlayerDemoTests
//
//  Created by Scott Quintana on 2/7/21.
//

import Foundation
@testable import ConchaLabsPlayerDemo

class MockAudioPlayer: AudioPlayer {
    var delegate: AudioPlayerDelegate?
    var status: PlayerStatus = .paused
    
    var playFunctionCalled: Bool = false
    var pauseFunctionCalled: Bool = false
    var volume: Float = 0.0
    
    
    func simulatePlay() {
        delegate?.playerStateDidChange(newStatus: .playing)
    }
    
    func simulatePause() {
        delegate?.playerStateDidChange(newStatus: .paused)
    }
    
    func play() {
        self.playFunctionCalled = true
    }
    
    func pause() {
        self.pauseFunctionCalled = true
    }
    
    func setVolume(_ level: Float) {
        self.volume = level
    }
}
