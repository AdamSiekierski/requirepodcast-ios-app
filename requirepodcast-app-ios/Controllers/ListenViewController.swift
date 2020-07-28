//
//  ListenViewController.swift
//  requirepodcast-app-ios
//
//  Created by Adam Siekierski on 06/06/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit

struct EpisodeDescription {
  var html: String?
  var markdown: String?
}

struct Episode {
  var id: String?
  var description: EpisodeDescription?
  var audioUrl: String?
  var publicationDate: Date?
  var shortDescription: String?
  var title: String?
  var youtubeUrl: String?
  var spotifyUrl: String?
}

class ListenViewController: UIViewController {
  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var episodeDescription: UILabel!
  @IBOutlet weak var playButton: UIButton!
  
  var episode:Episode = Episode()

  override func viewDidLoad() {
    super.viewDidLoad()

    let url = URL(string: "https://require.podcast.gq/episodes.json")!
    
    let session = URLSession.shared
    let task = session.dataTask(with: url, completionHandler: { data, response, error -> Void in
      do {
        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
        
        let episodes = json["episodes"] as! [Dictionary<String, AnyObject>]
        
        let episode = episodes.last
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: episode!["publicationDate"] as! String)
        
        self.episode = Episode(
          id: (episode!["id"] as! String),
          description: EpisodeDescription(html: (episode!["description"]?["html"] as! String), markdown: (episode!["description"]?["markdown"] as! String)),
          audioUrl: (episode!["audioUrl"] as! String),
          publicationDate: date,
          shortDescription: (episode!["shortDescription"] as! String),
          title: (episode!["title"] as! String),
          youtubeUrl: (episode!["youtubeUrl"] as! String),
          spotifyUrl: (episode!["spotifyUrl"] as! String)
        )

        DispatchQueue.main.async {
          self.updateData()
        }
      } catch {
      }
    })
    
    task.resume()
  }
  
  func updateData() {
    self.episodeTitle.text = self.episode.title
    self.episodeDescription.text = self.episode.shortDescription
  }
}
