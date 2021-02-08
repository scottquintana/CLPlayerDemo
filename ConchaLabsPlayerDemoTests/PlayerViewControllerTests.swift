//
//  PlayerViewControllerTests.swift
//  ConchaLabsPlayerDemoTests
//
//  Created by Scott Quintana on 2/7/21.
//

import XCTest
@testable import ConchaLabsPlayerDemo

class PlayerViewControllerTests: XCTestCase {

    var mockAudioPlayer: MockAudioPlayer!
    var vc: PlayerViewController!
    
    override func setUpWithError() throws {
        mockAudioPlayer = MockAudioPlayer()
        vc = PlayerViewController(audioPlayer: mockAudioPlayer, user: "Steve")
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        keyWindow?.rootViewController = vc
        vc.loadView()
        
        vc.audioPlayer = mockAudioPlayer
        mockAudioPlayer.delegate = vc
        
        let _ = vc.view
    }

   
    func testWhenInitialized_playButtonDisplaysPlay() throws {
        XCTAssertFalse(vc.playerView.playPauseButton.isSelected)
    }
    
    
    func testWhenPlayerStartsPlaying_changesButtonImageToPause() throws {
        mockAudioPlayer.simulatePlay()
        XCTAssertTrue(vc.playerView.playPauseButton.isSelected)
    }
    
    
    func testWhenPlayerStopsPlaying_changesButtonImageToPlay() throws {
        mockAudioPlayer.simulatePlay()
        mockAudioPlayer.simulatePause()
        XCTAssertFalse(vc.playerView.playPauseButton.isSelected)
    }
    
    
    func testPlayPauseButtonPress_callsPlayIfPaused() throws {
        mockAudioPlayer.status = .paused
        vc.playerView.playPauseButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockAudioPlayer.playFunctionCalled)
    }
    
    
    func testPlayPauseButtonPress_callsPauseIfPlaying() throws {
        mockAudioPlayer.status = .playing
        vc.playerView.playPauseButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockAudioPlayer.pauseFunctionCalled)
    }
    
    
    func testVolumeSliderChange_changesPlayerVolume() throws {
        vc.playerView.didChangeVolume(to: 0.25)
        XCTAssertEqual(mockAudioPlayer.volume, 0.25)
    }
}
