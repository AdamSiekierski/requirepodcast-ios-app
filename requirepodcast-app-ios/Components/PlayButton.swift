//
//  PlayButton.swift
//  requirepodcast-app-ios
//
//  Created by Adam Siekierski on 06/06/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit

class PlayButton: UIButton {
  override open var isHighlighted: Bool {
    didSet {
      backgroundColor = isHighlighted ? UIColor(named: "RequireRedDark") : UIColor(named: "RequireRed")
    }
  }
}
