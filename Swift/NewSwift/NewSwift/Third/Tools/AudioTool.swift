//
//  AudioTool.swift
//  Flag
//
//  Created by lh on 2018/8/4.
//  Copyright © 2018年 lh. All rights reserved.
//
import UIKit
import AVFoundation
class AudioTool: NSObject {
    
    class func playAudio(_ audioName: String, isAlert: Bool, completion: @escaping ()->()) {
        guard let url = Bundle.main.url(forResource: audioName, withExtension: nil) else { return }
        let urlCF = url as CFURL
        var soundID: SystemSoundID = 0
        
        AudioServicesCreateSystemSoundID(urlCF, &soundID)
        if isAlert {
            if #available(iOS 9.0, *) {
                AudioServicesPlayAlertSoundWithCompletion(soundID, {
                    AudioServicesDisposeSystemSoundID(soundID)
                    completion()
                })
            } else {
                // Fallback on earlier versions
            }
        }else {
            if #available(iOS 9.0, *) {
                AudioServicesPlaySystemSoundWithCompletion(soundID, {
                    AudioServicesDisposeSystemSoundID(soundID)
                    completion()
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
