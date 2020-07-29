//
//  EpisodeDetailViewController.swift
//  requirepodcast-app-ios
//
//  Created by Adam Siekierski on 05/06/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit
import Down

class EpisodeDetailViewController: UIViewController {
  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var pubDate: UILabel!
  @IBOutlet weak var episodeDescription: UITextView!
  @IBOutlet weak var playButton: PlayButton!
  
  var episode:Episode = Episode()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateValues()
  }
  
  func updateValues() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"

    episodeTitle.text = episode.title
    if let publicationDate = episode.publicationDate {
      pubDate.text = dateFormatter.string(from: publicationDate)
    }
    
    if let description = episode.description?.markdown {
      let down = Down(markdownString: description)
      
      let mode = traitCollection.userInterfaceStyle
      
      let stylesheet = """
      * {
        color: \(mode == .dark ? "white" : "black");
        font-family: monospace;
        font-size: 16px;
        margin: 16px 0;
      }
      
      li {
        margin-top: 0;
        margin-bottom: 0;
      }
      
      ul > li:first-of-type {
        margin-top: 10px;
      }
      
      ul > li:last-of-type {
        margin-bottom: 10px;
      }
      """
      
      if let attributedString = try? down.toAttributedString(stylesheet: stylesheet) {
        self.episodeDescription.attributedText = attributedString
      }
    }
  }

  @IBAction func onPlayPressed(_ sender: Any) {
    PlayerManager.shared.play(episode: self.episode)
  }
}
