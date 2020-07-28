//
//  ViewController.swift
//  requirepodcast-app-ios
//
//  Created by Adam Siekierski on 05/06/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit

class EpisodeListViewController: UITableViewController, UISearchResultsUpdating {
  var episodes:[Episode] = []
  var filteredEpisodes:[Episode] = []
  var searchController = UISearchController(searchResultsController: nil)
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.getData()

    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Znajdź odcinek"
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
  }
  
  func getData() {
    let url = URL(string: "https://require.podcast.gq/episodes.json")!
    
    let session = URLSession.shared
    let task = session.dataTask(with: url, completionHandler: { data, response, error -> Void in
      do {
        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
        
        let episodes = json["episodes"] as! [Dictionary<String, AnyObject>]

        for episode in episodes.reversed() {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd"
          let date = dateFormatter.date(from: episode["publicationDate"] as! String)
          
          self.episodes.append(Episode(
            id: (episode["id"] as! String),
            description: EpisodeDescription(html: (episode["description"]?["html"] as! String), markdown: (episode["description"]?["markdown"] as! String)),
            audioUrl: (episode["audioUrl"] as! String),
            publicationDate: date,
            shortDescription: (episode["shortDescription"] as! String),
            title: (episode["title"] as! String),
            youtubeUrl: (episode["youtubeUrl"] as! String),
            spotifyUrl: (episode["spotifyUrl"] as! String)
            )
          )
        }
        
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      } catch {
      }
    })
    
    task.resume()
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "episodeListCell", for: indexPath)
    
    cell.textLabel!.text = (isSearchBarEmpty ? episodes : filteredEpisodes)[indexPath.row].title

    return cell
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (isSearchBarEmpty ? episodes : filteredEpisodes).count
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let nextViewController = segue.destination as? EpisodeDetailViewController {
      let indexPath = self.tableView.indexPathForSelectedRow!
      nextViewController.episode = (isSearchBarEmpty ? episodes : filteredEpisodes)[indexPath.row]
      self.tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    if let searchText = searchController.searchBar.text {
      self.filteredEpisodes = episodes.filter { (episode: Episode) -> Bool in
        return (episode.title?.lowercased().contains(searchText.lowercased()) ?? true)
      }
      
      self.tableView.reloadData()
    }
  }
}
