//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Josh on 2/22/16.
//  Copyright © 2016 Foomon Inc. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if var filePath = NSBundle.mainBundle().pathForResource("slow", ofType: "mp3"){
        //            let fileUrl = NSURL(fileURLWithPath: filePath)
        //
        //
        //        }else {
        //
        //            print("the filePath is empty")
        //        }
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        
        
    }
    
//    func audioPlay(Int speed) {
//        
//        audioPlayer.stop()
//        audioPlayer.rate(speed)
//        audioPlayer.currentTime = 0.0
//        audioPlayer.play()
//    }
    
    @IBAction func playDarthVader(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
        
    }
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format:  nil)
        audioEngine.connect(changePitchEffect, to:audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        try! audioEngine.start()
        
        audioPlayerNode.play()
        
    }
    
    @IBAction func slow(sender: AnyObject) {
       
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
        
    }
    
    @IBAction func fast(sender: AnyObject) {
        
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func stop(sender: AnyObject) {
        
        audioPlayer.stop()
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
