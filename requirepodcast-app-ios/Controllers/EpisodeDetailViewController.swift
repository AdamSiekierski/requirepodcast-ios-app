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
      pubDate.text = "Data publikacji: \(dateFormatter.string(from: publicationDate))"
    }
    
    if let description = episode.description?.html {
      episodeDescription.text = description.htmlToString
    }
  }
}
