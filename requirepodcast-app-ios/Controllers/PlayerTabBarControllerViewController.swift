//
//  PlayerTabBarControllerViewController.swift
//  requirepodcast-app-ios
//
//  Created by Adam Siekierski on 07/06/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit

class PlayerTabBarControllerViewController: UITabBarController, UITabBarControllerDelegate {
  var playerView = PlayerView(frame: CGRect.zero)

  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    
    self.view.addSubview(playerView)
    playerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      playerView.bottomAnchor.constraint(equalTo: self.tabBar.topAnchor),
      playerView.leadingAnchor.constraint(equalTo: self.tabBar.leadingAnchor),
      playerView.trailingAnchor.constraint(equalTo: self.tabBar.trailingAnchor),
      playerView.heightAnchor.constraint(equalToConstant: 65),
    ])
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    
    for viewController in self.viewControllers! {
      var newSafeArea = UIEdgeInsets()
      
      newSafeArea.bottom += playerView.bounds.size.height
      
      viewController.additionalSafeAreaInsets = newSafeArea
    }
  }
}
