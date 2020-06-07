//
//  PlayerView.swift
//  requirepodcast-app-ios
//
//  Created by Adam Siekierski on 07/06/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit

class PlayerView: UIView {
  @IBOutlet var playerView: UIView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
  }
}
