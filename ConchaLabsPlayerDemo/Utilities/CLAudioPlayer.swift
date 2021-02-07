//
//  CLAudioPlayer.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/5/21.
//

import Foundation
import AVFoundation

protocol AudioPlayer {
    func playPause()
    func setVolume(_ level: Float)
}

class CLAudioPlayer: AudioPlayer {
    
    let defaults = UserDefaults.standard
    
    private var engine = AVAudioEngine()
    private var mainMixer: AVAudioMixerNode!
    private var player = AVAudioPlayerNode()
    private var audioFormat: AVAudioFormat!
    var audioSessionObserver: Any!
    
    private var audioFrameCount: UInt32!
    private var audioFileBuffer: AVAudioPCMBuffer!
    
    var isPlaying: Bool {
        return player.isPlaying
    }
    
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
        configureAudioSession()
        scheduleAudioFile()
    }
    
    
    private func configurePlayer() {
        audioFileURL = Bundle.main.url(forResource: "casioloop", withExtension: "wav")
        mainMixer = engine.mainMixerNode
        mainMixer.outputVolume = defaults.object(forKey: "volume") as? Float ?? 0.5
        engine.attach(player)
        engine.connect(player, to: mainMixer, format: audioFormat)
        print(engine.outputNode)
        
    }
    
    
    private func scheduleAudioFile(){
        guard let audioFile = audioFile else { return }
        
        player.scheduleFile(audioFile, at: nil)
        player.scheduleBuffer(audioFileBuffer, at: nil, options: .loops, completionHandler: nil)
    }
    
    
    func playPause() {
   
        
        if player.isPlaying {
            engine.pause()
            player.pause()
            print("pause")
        } else {
            do {
                try engine.start()
            } catch {
                print("Error starting engine")
            }
            print("play")
            player.play()
        }
    }
    
    
    func setVolume(_ level: Float) {
        mainMixer?.outputVolume = level
        defaults.setValue(level, forKey: "volume")
    }
    
    func configureAudioSession() {
        do{
            if #available(iOS 10.0, *) {
                try AVAudioSession.sharedInstance().setCategory(.playAndRecord,
                                                                mode: .default, options: [.mixWithOthers, .allowAirPlay,
                .allowBluetoothA2DP,.defaultToSpeaker])
                print("ios 10 and above")

            } else {
                 print("ios 10 and lower")
                let options: [AVAudioSession.CategoryOptions] =
                [.mixWithOthers, .allowBluetooth]
                let category = AVAudioSession.Category.playAndRecord
                let selector =
                NSSelectorFromString("setCategory:withOptions:error:")
                AVAudioSession.sharedInstance().perform(selector, with:
                 category, with: options)
            }

            try AVAudioSession.sharedInstance().setActive(true)
            
        } catch {
            print("There were errors")
        }
    }
    
    func observer() {
        let notificationCenter = NotificationCenter.default
        
        audioSessionObserver = notificationCenter.addObserver(forName: AVAudioSession.routeChangeNotification,
                                                              object: nil,
                                                              queue: nil) { [unowned self] _ in
            if player.isPlaying {
                self.playPause()
            } else {
                engine.pause()
            }
        }
        
        // Configure the audio session initially.
    
    }
}
