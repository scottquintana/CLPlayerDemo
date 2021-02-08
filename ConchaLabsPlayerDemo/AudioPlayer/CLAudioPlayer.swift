//
//  CLAudioPlayer.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/5/21.
//

import Foundation
import AVFoundation



class CLAudioPlayer: AudioPlayer {
    
    let defaults = UserDefaults.standard
    private var audioSessionObserver: Any!
    
    private var engine = AVAudioEngine()
    private var mainMixer: AVAudioMixerNode!
    private var player = AVAudioPlayerNode()
    private var audioFormat: AVAudioFormat!
    
    
    private var audioFrameCount: UInt32!
    private var audioFileBuffer: AVAudioPCMBuffer!
    
    weak var delegate: AudioPlayerDelegate?
    
    var status: PlayerStatus = .paused
    
    private var audioFile: AVAudioFile? {
        didSet {
            if let audioFile = audioFile {
                audioFormat = audioFile.processingFormat
                audioFrameCount = UInt32(audioFile.length)
                audioFileBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount)
            }
        }
    }
    
    
    private var audioFileURL: URL? {
        didSet {
            if let audioFileURL = audioFileURL {
                audioFile = try? AVAudioFile(forReading: audioFileURL)
                do {
                    try audioFile?.read(into: audioFileBuffer)
                } catch {
                    print("Error reading file buffer")
                }
            }
        }
    }
    
    
    init() {
        observer()
        configurePlayer()
        scheduleAudioFile()
    }
    
    
    private func configurePlayer() {
        audioFileURL = Bundle.main.url(forResource: "casioloop", withExtension: "wav")
        mainMixer = engine.mainMixerNode
        mainMixer.outputVolume = defaults.object(forKey: "volume") as? Float ?? 0.5
        engine.attach(player)
        engine.connect(player, to: mainMixer, format: audioFormat)
    }
    
    
    private func scheduleAudioFile(){
        guard let audioFile = audioFile else { return }
        
        player.scheduleFile(audioFile, at: nil)
        player.scheduleBuffer(audioFileBuffer, at: nil, options: .loops, completionHandler: nil)
    }
    
    func play() {
        status = .playing
        do {
            engine.prepare()
            try engine.start()
        } catch {
            print("Error starting engine")
        }
        player.play()
        delegate?.playerStateDidChange(newStatus: status)
    }
    
    
    func pause() {
        status = .paused
        engine.pause()
        player.pause()
        delegate?.playerStateDidChange(newStatus: status)
    }
    
    
    func setVolume(_ level: Float) {
        mainMixer?.outputVolume = level
        defaults.setValue(level, forKey: "volume")
    }
    
    
    private func observer() {
        let notificationCenter = NotificationCenter.default
        
        audioSessionObserver = notificationCenter.addObserver(forName: AVAudioSession.routeChangeNotification, object: nil, queue: nil) { [weak self] _ in
            guard let self = self else { return }
            
            if self.status == .playing {
                self.pause()
            }
            
        }
    }
}
