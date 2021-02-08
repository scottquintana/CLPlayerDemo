//
//  AudioPlayerDelegate.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/7/21.
//

import Foundation

protocol AudioPlayerDelegate: class {
    func playerStateDidChange(newStatus: PlayerStatus)
}
