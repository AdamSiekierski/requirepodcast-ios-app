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
    // Do any additional setup after loading the view.
    self.getData()

    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Znajdź odcinek"
    navigationItem.searchController = searchController
  }
  
  func getData() {
    let url = URL(string: "https://anchor.fm/s/139df89c/podcast/rss")!
    let episodeParser = PodcastRSSParser()
    episodeParser.parse(url: url) { episodes in
      self.episodes = episodes
    }
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
    }
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    if let searchText = searchController.searchBar.text {
      self.filteredEpisodes = episodes.filter { (episode: Episode) -> Bool in
        return episode.title.lowercased().contains(searchText.lowercased())
      }
      
      self.tableView.reloadData()
    }
  }
}
