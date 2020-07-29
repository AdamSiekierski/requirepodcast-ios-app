//
//  PlayerViewDelegate.swift
//  requirepodcast-app-ios
//
//  Created by Adam Siekierski on 29/07/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import AVFoundation

extension Notification.Name {
  static var play: Notification.Name {
    return .init("PlayerManager.play")
  }
  
  static var pause: Notification.Name {
    return .init("PlayerManager.pause")
  }
}

class PlayerManager {
  static var shared = PlayerManager()
  
  var player: AVPlayer?
  var playing: Bool
  var episode: Episode?
  
  private let notificationCenter: NotificationCenter
  
  private init(notificationCenter: NotificationCenter = .default) {
    self.playing = false
    self.notificationCenter = notificationCenter
  }
  
  func play(episode: Episode?) {
    if let audioUrl = episode?.audioUrl {
      self.episode = episode
      self.player = AVPlayer(url: URL(string: audioUrl)!)
    }
    
    
    if let player = self.player {
      player.play()
      
      self.playing = true
      self.notificationCenter.post(Notification(name: .play, object: self.episode))
    }
  }
  
  func pause() {
    if let player = self.player {
      player.pause()
      
      self.playing = false
      self.notificationCenter.post(Notification(name: .pause))
    }
  }
  
  func seek(sec: Double) {
    if let player = self.player {
      let time = CMTimeMakeWithSeconds(CMTimeGetSeconds(player.currentTime()) + sec, preferredTimescale: player.currentTime().timescale);
      
      player.seek(to: time)
    }
  }
}
