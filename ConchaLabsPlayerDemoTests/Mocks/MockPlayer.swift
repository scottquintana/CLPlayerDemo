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
    var setVolumeCalled: Bool = false
    
    
    func simulatePlay() {
        delegate?.playerStateDidChange(newStatus: .playing)
    }
    
    func simulatePause() {
        delegate?.playerStateDidChange(newStatus: .paused)
    }
    
    func play() {
        playFunctionCalled = true
    }
    
    func pause() {
        pauseFunctionCalled = true
    }
    
    func setVolume(_ level: Float) {
        setVolumeCalled = true
    }
}
