//
//  PlayerViewControllerTests.swift
//  ConchaLabsPlayerDemoTests
//
//  Created by Scott Quintana on 2/7/21.
//

import XCTest
@testable import ConchaLabsPlayerDemo

class PlayerViewControllerTests: XCTestCase {

    var vc = PlayerViewController()
    var mockAudioPlayer = MockAudioPlayer()
    
    override func setUpWithError() throws {
        vc.loadView()
        
        vc.audioPlayer = mockAudioPlayer
        mockAudioPlayer.delegate = vc
        
//        let _ = vc.view
    }

   
    func testWhenInitialized_playButtonDisplaysPlay() throws {
        XCTAssertFalse(vc.playerView.playPauseButton.isSelected)
    }
    
    func testWhenPlayerStartsPlaying_changesButtonImageToPause() throws {
        mockAudioPlayer.simulatePlay()
        XCTAssertTrue(vc.playerView.playPauseButton.isSelected)
    }
    
    func testWhenPlayerStopsPlaying_changesButtonTextToPlay() throws {
        mockAudioPlayer.simulatePlay()
        mockAudioPlayer.simulatePause()
        XCTAssertFalse(vc.playerView.playPauseButton.isSelected)
    }

}
