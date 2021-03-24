//
//  SHYSound.swift
//  ClockPro
//
//  Created by MrSui on 2020/10/23.
//

import Foundation
import SwiftyUserDefaults
import SwiftUI

class SHYClockControl: ObservableObject {
    
    @Published var index = Defaults.clockIndex
}



class SHYTimeControl: ObservableObject {
    @Published var timeIntArr = [10,5*60,10*60,15*60,20*60,25*60,30*60,35*60,40*60,45*60,50*60,55*60]
    @Published var dataArr  = ["00:10","05:00","10:00","15:00","20:00","25:00","30:00","35:00","40:00","45:00","50:00","55:00"]
    @Published var index = Defaults.timeIndex
}



class SHYBackSoundControl: ObservableObject {
    @Published var dataArr = [
        "虫鸣",
        "丛林",
        "大海鸟叫",
        "风吹落叶",
        "风铃鸟鸣",
        "火燃烧声",
        "雷雨",
        "瓢泼大雨",
        "森林",
        "时钟",
        "时钟2",
        "时钟3",
        "时钟4",
        "时钟5",
        "时钟6",
        "溪流",
        "小雨",
        "夜晚蝉鸣"
        
    ]
    @Published var index = Defaults.backSoundIndex
}

class SHYEndSoundControl: ObservableObject {
    @Published var dataArr = [
        "提示音1",
        "提示音2",
        "提示音3",
        "提示音下课铃1",
        "提示音下课铃2"
    ]
    @Published var index = Defaults.endSoundIndex
}



class SHYSound {
    static let ArClYellowRaw = [UIColor.init(red: 234/255, green: 210/255, blue: 105/255, alpha: 1),
                                UIColor.init(red: 240/255, green: 240/255, blue: 171/255, alpha: 1),
                                UIColor.init(red: 222/255, green: 212/255, blue: 96/255, alpha: 1),
                                UIColor.init(red: 246/255, green: 249/255, blue: 142/255, alpha: 1),
                                UIColor.init(red: 225/255, green: 202/255, blue: 14/255, alpha: 1),]
    static func playEndSound() { //播放走表结束音乐,选中好了什么就播什么
        let endControl = SHYEndSoundControl()
        let stName = "\(endControl.dataArr[Defaults.endSoundIndex]).mp3"
        print("End->\(stName)")
        MusicTools.sharePlayer.playMusic(musicName: stName)
    }
    
    
    static func playBackgroundSound() { //播放背景音乐,选中好了什么就播什么
        let backGroundControl = SHYBackSoundControl()
        let stName = "\(backGroundControl.dataArr[Defaults.backSoundIndex]).mp3"
        print("Background->\(stName)")
        MusicTools.sharePlayer.loopOnePlayerMusic(musicName: stName)
    }
    static func stopPlayBackgroundSound() { //停止播放当前的背景音乐.
        MusicTools.sharePlayer.loopOnePlayer?.stop()
    }
    
    // 为了让被电话打扰后,能继续播放声音.
    static func ifBeStopedThenGoOnPlayMusic() {
        if MusicTools.isMusicBeInterupted  {
            MusicTools.isMusicBeInterupted = false
            playBackgroundSound()
        }
    }
}


extension DefaultsKeys {
    var tomatoRecords: DefaultsKey<[TomatoRecord]> { .init("tomatoRecords", defaultValue: []) } // 所有的记录
    var backSoundIndex: DefaultsKey<Int> { .init("backSoundIndex", defaultValue: 0) } // 当前背景音乐的选择index
    var endSoundIndex: DefaultsKey<Int> { .init("endSoundIndex", defaultValue: 0) } //当前走表结束音乐的选择的index
    var timeIndex: DefaultsKey<Int> { .init("timeIndex", defaultValue: 0) } //当前走表结束音乐的选择的index
    
    var clockIndex: DefaultsKey<Int> { .init("clockIndex", defaultValue: 0) } //当前走表结束音乐的选择的index
    
    var isFirstApp: DefaultsKey<Bool> { .init("clockIndex", defaultValue: true) } //当前走表结束音乐的选择的index
}
