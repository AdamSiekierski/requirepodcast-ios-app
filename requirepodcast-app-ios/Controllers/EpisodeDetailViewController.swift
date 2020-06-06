//
//  EpisodeDetailViewController.swift
//  requirepodcast-app-ios
//
//  Created by Adam Siekierski on 05/06/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
  var episode:Episode = Episode(title: "", description: "", audioUrl: "", pubDate: Date())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = String(episode.title.split(separator: "-")[0])
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
