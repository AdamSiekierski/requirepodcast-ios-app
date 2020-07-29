//
//  PlayerView.swift
//  requirepodcast-app-ios
//
//  Created by Adam Siekierski on 08/06/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit

class PlayerView: UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var controlButon: UIButton!
  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var seekButton: UIButton!
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)

    commonInit()
  }
  
  private func commonInit() {
    Bundle.main.loadNibNamed("PlayerView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    
    // Bottom border
    let borderView = UIView(frame: CGRect.zero)
    borderView.backgroundColor = UIColor.opaqueSeparator
    self.addSubview(borderView)
    borderView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint.activate([
      borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      borderView.heightAnchor.constraint(equalToConstant: 0.5)
    ])
    
    NotificationCenter.default.addObserver(self, selector: #selector(onPlay(_:)), name: .play, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(onPause(_:)), name: .pause, object: nil)
    
    if (PlayerManager.shared.episode == nil) {
      self.controlButon.isEnabled = false
      self.seekButton.isEnabled = false
    }
  }
  
  @objc private func onPlay(_ notification: Notification) {
    self.controlButon.setImage(UIImage(systemName: "pause.fill"), for: .normal)

    self.controlButon.isEnabled = true
    self.seekButton.isEnabled = true
    
    if let episode = notification.object as? Episode {
      self.episodeTitle.text = episode.title
    }
  }
  
  @objc private func onPause(_ notification: Notification) {
    self.controlButon.setImage(UIImage(systemName: "play.fill"), for: .normal)
  }

  @IBAction func onButtonPressed(_ sender: Any) {
    if PlayerManager.shared.playing {
      PlayerManager.shared.pause()
    } else {
      PlayerManager.shared.play(episode: nil)
    }
  }

  @IBAction func onSeek(_ sender: Any) {
    PlayerManager.shared.seek(sec: 30)
  }
}
