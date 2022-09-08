//
//  ViewModel_SoundManager.swift
//  uhub
//
//  Created by Truong Nhat Anh on 08/09/2022.
//

import Foundation

import AVFoundation

var music: AVAudioPlayer?

// List of sounds
var sounds = [AVAudioPlayer]()

// Play music function
func playMusic(sound:String, isLoop:Bool) {
    
    let path = Bundle.main.path(forResource: sound, ofType: "mp3")!
    let url = URL(fileURLWithPath: path)
    
    do {
        
        music = try AVAudioPlayer(contentsOf: url)
        
        // Check if the play is loop
        if (isLoop) {
            music?.numberOfLoops = -1
            if (sounds.count > 0) {
                sounds[0] = music!
            } else {
                sounds.append(music!)
            }
            
            music?.setVolume(0.3, fadeDuration: 0.5)
            sounds.last?.prepareToPlay()
            sounds.last?.play()
            return
        }
        
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        try AVAudioSession.sharedInstance().setActive(true)
        
        sounds.append(music!)
        sounds.last?.prepareToPlay()
        sounds.last?.play()
        
        
    } catch {
        print("Cannot find the sound!")
    }
    
}

// Mute all the sound
func emptyMusic() {

    // Loop through sounds and stop each sound
    for music in sounds {
        music.stop()
    }
    
    sounds.removeAll()
}
