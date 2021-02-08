//
//  AudioPlayerProtocol.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/7/21.
//

import Foundation

enum PlayerStatus {
    case playing, paused
}

protocol AudioPlayer {
    var status: PlayerStatus { get set }
    var delegate: AudioPlayerDelegate? { get set }
    
    func play()
    func pause()
    func setVolume(_ level: Float)
}
