//
//  EpisodeDetailViewController.swift
//  requirepodcast-app-ios
//
//  Created by Adam Siekierski on 05/06/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var pubDate: UILabel!
  @IBOutlet weak var episodeDescription: UILabel!
  
  var episode:Episode = Episode(title: "", description: "", audioUrl: "", pubDate: Date())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateValues()
  }
  
  func updateValues() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"

    episodeTitle.text = episode.title
    pubDate.text = "Data publikacji: \(dateFormatter.string(from: episode.pubDate))"
    episodeDescription.text = self.episode.description.htmlToString
  }
}
