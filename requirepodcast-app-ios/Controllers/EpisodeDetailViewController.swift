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
  
  var episode:Episode = Episode(title: "", description: "", audioUrl: "", pubDate: Date())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateValues()
  }
  
  func updateValues() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"

    // navigationItem.title = String(episode.title.split(separator: "-")[0])
    // episodeTitle.text = String(episode.title.split(separator: "-")[1].trimmingCharacters(in: .whitespacesAndNewlines))
    episodeTitle.text = episode.title
    pubDate.text = "Data publikacji: \(dateFormatter.string(from: episode.pubDate))"
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
