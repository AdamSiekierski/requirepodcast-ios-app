//
//  ViewController.swift
//  requirepodcast-app-ios
//
//  Created by Adam Siekierski on 05/06/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit

class EpisodeListViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "episodeListCell", for: indexPath)
    cell.textLabel!.text = "dupa"
    
    return cell
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
}

