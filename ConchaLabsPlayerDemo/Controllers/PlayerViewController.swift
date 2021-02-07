//
//  PlayerViewController.swift
//  ConchaLabsPlayerDemo
//
//  Created by Scott Quintana on 2/5/21.
//

import UIKit
import AVFoundation
import AVKit

class PlayerViewController: UIViewController {
    var greetingLabel: CLTitleLabel!
    let playerView = PlayerView()
    var audioPlayer: AudioPlayer!
    var bluetoothButton: CLButton!
    var user = "User"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.cream
        title = "CL Player"
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isTranslucent = false
        greetingLabel = CLTitleLabel(textAlignment: .center, fontSize: 32, fontColor: Colors.lightGrey)
        greetingLabel.text = "Hello, \(user)!"
        
        playerView.delegate = self
        configurePlayer()
    }
    
    convenience init(audioPlayer: AudioPlayer, user: String) {
        self.init()
        self.audioPlayer = audioPlayer
        self.user = user
    }
    
    private func configurePlayer() {
        bluetoothButton = CLButton(title: "CONNECT TO BLUETOOTH", backgroundColor: Colors.gold)
        view.addSubview(greetingLabel)
        view.addSubview(playerView)
        view.addSubview(bluetoothButton)
        
        let routePickerView = AVRoutePickerView()
        routePickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(routePickerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        bluetoothButton.addTarget(self, action: #selector(connectMenu), for: .touchUpInside)
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            greetingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            greetingLabel.bottomAnchor.constraint(equalTo: playerView.topAnchor, constant: -padding),
            
            playerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            playerView.heightAnchor.constraint(equalToConstant: 250),
            
            bluetoothButton.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 20),
            bluetoothButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bluetoothButton.widthAnchor.constraint(equalToConstant: 170),
            bluetoothButton.heightAnchor.constraint(equalToConstant: 34),
            
            routePickerView.topAnchor.constraint(equalTo: bluetoothButton.bottomAnchor, constant: padding)
        ])
    }
    
    func startAudio() {
        audioPlayer.playPause()
    }
    
    @objc func connectMenu() {
//        if let session = AVAudioSession.sharedInstance().outputDataSources {
//        bringupAudioDeviceSheet(availableAudioPorts: session)
//        } else {
//            print("No output source")
//        }
        popupMenu()
    }

//    private func bringupAudioDeviceSheet(availableAudioPorts:[AVAudioSessionDataSourceDescription]) {
//            let alertController = UIAlertController(title: nil,
//                                                    message: nil,
//                                                    preferredStyle: .actionSheet)
//            for audioPort in availableAudioPorts {
//                let action = UIAlertAction(title: audioPort.dataSourceName, style: .default) { (action) in
//                    try? AVAudioSession.sharedInstance().setOutputDataSource(audioPort)
//                }

//                var imageName: String?  = nil;
//                switch audioPort.dataSourceName {
//                case AVAudioSession.Port.builtInMic:
//                    imageName = "ic_36dp_phone"
//                case AVAudioSession.Port.builtInSpeaker:
//                    imageName = "ic_36dp_speaker"
//                case AVAudioSession.Port.headsetMic:
//                    imageName = "ic_36dp_headset"
//                case AVAudioSession.Port.headphones:
//                    imageName = "ic_36dp_headset"
//                case AVAudioSession.Port.bluetoothHFP:
//                    imageName = "ic_36dp_bluetooth"
//                case AVAudioSession.Port.bluetoothA2DP:
//                    imageName = "ic_36dp_bluetooth"
//                    default: break
//                }
//                if imageName != nil {
//                    if let image = UIImage(named: imageName!) {
//
//                        action.setValue(image, forKey: "image")
//                    }
//                }
//                alertController.addAction(action)
//
//
//            }
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//                // Do nothing
//            }
//            alertController.addAction(cancelAction)
//            self.present(alertController, animated: true, completion: nil)
//            // auto dismiss after 5 seconds
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                alertController.dismiss(animated: true, completion: nil)
//            }
//        }
    func popupMenu() {
     let model = UIDevice().localizedModel
            
        let session = AVAudioSession.sharedInstance()
            
    let alertController = UIAlertController(title: "Select Output", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        alertController.addAction(UIAlertAction(title: model, style: UIAlertAction.Style.default, handler: { action in
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        } catch {
            print("AVAudioSession error!")
        }
        }))
        alertController.addAction(UIAlertAction(title: "Bluetooth", style: UIAlertAction.Style.default, handler: { action in
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.allowBluetoothA2DP)
            try session.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
        } catch {
            print("AVAudioSession error!")
        }
        }))
        present(alertController, animated: true, completion: nil)
    }
    
}
    
    


extension PlayerViewController: PlayerViewDelegate {
    func togglePlayPause() {
        audioPlayer.playPause()
    }
    
    func volumeDidChange(to volume: Float) {
        audioPlayer.setVolume(volume)
    }
    
    
    
}
