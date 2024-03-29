/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Authors:
 + S3877980 - Ho Le Minh Thach
 + S3878231 - Truong Nhat Anh
 + S3877698 - Nguyen Luu Quoc Bao
 + S3820098  - Le Nguyen Truong An
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Acknowledgements: Learning from Hacking with Swift to implement MVVM, and the usage of CoreData
 Hudson, P. (n.d.). The 100 days of Swiftui. Hacking with Swift. Retrieved July 30, 2022, from https://www.hackingwithswift.com/100/swiftui
*/

import Foundation

import AVFoundation

var music: AVAudioPlayer?

// List of sounds
var sounds = [AVAudioPlayer]()


/// This function used tio play music
/// - Parameters:
///   - sound: music to play
///   - isLoop: if play infinitely
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


/// This function used to stop all sound
func emptyMusic() {
    
    // Loop through sounds and stop each sound
    for music in sounds {
        music.stop()
    }
    
    sounds.removeAll()
}
