//
//  ListenViewController.swift
//  requirepodcast-app-ios
//
//  Created by Adam Siekierski on 06/06/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit

class ListenViewController: UIViewController {
  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var episodeDescription: UILabel!
  @IBOutlet weak var playButton: UIButton!
  
  var episode:Episode = Episode(title: "", description: "", audioUrl: "", pubDate: Date())

  override func viewDidLoad() {
    super.viewDidLoad()
    updateData()

    let url = URL(string: "https://anchor.fm/s/139df89c/podcast/rss")!
    let episodeParser = PodcastRSSParser()
    episodeParser.parse(url: url) { episodes in
      self.episode = episodes.first!
      
      DispatchQueue.main.async {
        self.updateData()
      }
    }
  }
  
  func updateData() {
    self.episodeTitle.text = self.episode.title
    self.episodeDescription.text = self.episode.description.htmlToString
  }
}
