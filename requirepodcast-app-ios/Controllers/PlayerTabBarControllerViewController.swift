//
//  PlayerTabBarControllerViewController.swift
//  requirepodcast-app-ios
//
//  Created by Adam Siekierski on 07/06/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit

class PlayerTabBarControllerViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let playerView = PlayerView(frame: CGRect.zero)
    self.tabBar.addSubview(playerView)
    playerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      playerView.bottomAnchor.constraint(equalTo: self.tabBar.topAnchor),
      playerView.leadingAnchor.constraint(equalTo: self.tabBar.leadingAnchor),
      playerView.trailingAnchor.constraint(equalTo: self.tabBar.trailingAnchor),
      playerView.heightAnchor.constraint(equalToConstant: 65)
    ])
  }
  

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }
  */

}
