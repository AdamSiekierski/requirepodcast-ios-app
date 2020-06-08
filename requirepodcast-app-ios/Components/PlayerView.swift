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
  }
}
