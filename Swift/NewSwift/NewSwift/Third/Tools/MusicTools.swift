//
//  MusicTools.swift
//  Ios项目forQQ音乐
//
//  Created by Ann on 2017/9/21.
//  Copyright © 2017年 Ann. All rights reserved.
//

import Foundation

//3.2 创建音乐播放工具类，引入AVFoundation头文件

import AVFoundation
class MusicTools {
    
    var onePlayer :AVAudioPlayer?
    var loopOnePlayer:AVAudioPlayer?
    var loopTwoPlayer:AVAudioPlayer?
    //3.2.1 创建类单例
    static let sharePlayer: MusicTools = {
        
        let player =  MusicTools()
        
        return player
    }()
    
    // 添加为了被打扰后能继续播放音乐
    static var isNotificationAdded = false
    static var isMusicBeInterupted = false
    
    //3.2.2 播放音乐通过名字
    func playMusic(musicName:String){
        
        guard let pathURL = Bundle.main.url(forResource: musicName, withExtension: nil) else {
            print("no this MusicName")
            return
        }
        
        if pathURL == onePlayer?.url {
            onePlayer?.play()
            return
        }
        //磁盘加载音频
        guard let musicTrue = try? AVAudioPlayer(contentsOf: pathURL) else {
            return
        }
        onePlayer = musicTrue
        
        onePlayer?.play()
    }
    //3.2.3 音频暂停
    func pausePlayer(){
        onePlayer?.pause()
    }
    
    // 循环播放功能
    func loopOnePlayerMusic(musicName:String){
        // 为了让被打扰的音频播放可以继续
        if !MusicTools.isNotificationAdded {
            SHYPulic.Log(string: " 循环播放通知")
            MusicTools.isNotificationAdded = true
            NotificationCenter.default.addObserver(self, selector: #selector(audioStart(_:)), name:  AVAudioSession.interruptionNotification, object: nil)
        }
        
        guard let pathURL = Bundle.main.url(forResource: musicName, withExtension: nil) else {
            print("no this MusicName")
            return
        }
        
        if pathURL == loopOnePlayer?.url {
            loopOnePlayer?.play()
            return
        }
        //磁盘加载音频
        guard let musicTrue = try? AVAudioPlayer(contentsOf: pathURL) else {
            return
        }
        loopOnePlayer = musicTrue
        loopOnePlayer?.numberOfLoops = -1
        loopOnePlayer?.play()
    }
    
    // 循环播放功能,创建第二个,避免播放钟表时候再播放效果会出问题.
    func loopTwoPlayerMusic(musicName:String){
        
        guard let pathURL = Bundle.main.url(forResource: musicName, withExtension: nil) else {
            print("no this MusicName")
            return
        }
        
        if pathURL == loopTwoPlayer?.url {
            loopTwoPlayer?.play()
            return
        }
        //磁盘加载音频
        guard let musicTrue = try? AVAudioPlayer(contentsOf: pathURL) else {
            return
        }
        loopTwoPlayer = musicTrue
        loopTwoPlayer?.numberOfLoops = -1
        loopTwoPlayer?.play()
    }
    
    @objc func audioStart(_ note: Notification){
        //print("addInterruptionSession \(note) \(note.userInfo![AVAudioSessionInterruptionTypeKey])")
        
        if AVAudioSession.InterruptionType.began.rawValue == note.userInfo![AVAudioSessionInterruptionTypeKey] as? UInt{
            if MusicTools.sharePlayer.loopOnePlayer != nil && MusicTools.sharePlayer.loopOnePlayer!.isPlaying {
                MusicTools.isMusicBeInterupted = true
            }
            //暂停音频
            
        } else if AVAudioSession.InterruptionType.ended.rawValue == note.userInfo![AVAudioSessionInterruptionTypeKey]as? UInt{
            SHYPulic.Log(string: " 收到音频中断结束通知")
            //恢复音频.
        }
    }
    
    
    
}
extension MusicTools{
    //4.1 获取歌曲总长度
    func getDuration() -> TimeInterval {
        return  onePlayer?.duration ?? 0
    }
    //4.2 获取当前播放时间
    func getCurrentTime() -> TimeInterval{
        return  onePlayer?.currentTime ?? 0
    }
    //4.3 设置从当前时间开始播放
    func setPlayCurrentTime(ct:TimeInterval){
        onePlayer?.currentTime = ct
    }
    //代理
    func delegateOfAVAudioPlayerDelegate(delegate:AVAudioPlayerDelegate){
        onePlayer?.delegate = delegate
    }
}
