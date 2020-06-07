//
//  PodcastRSSParser.swift
//  requirepodcast-app-ios
//
//  Created by Adam Siekierski on 06/06/2020.
//  Copyright © 2020 AdamSiekierski. All rights reserved.
//

import UIKit

struct Episode {
  var title: String
  var description: String
  var audioUrl: String
  var pubDate: Date
}

class PodcastRSSParser: NSObject, XMLParserDelegate {
  var episodes:[Episode] = []
  private var handler:(([Episode]) -> Void)? = nil
  private var currentElement = ""

  func parse(url: URL, finishHandler: @escaping ([Episode]) -> Void) {
    self.handler = finishHandler

    let rssParser = XMLParser(contentsOf: url)!
    rssParser.delegate = self
    rssParser.parse()
  }
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    if (elementName == "item") {
      episodes.append(Episode(title: "", description: "", audioUrl: "", pubDate: Date()))
    }
    
    currentElement = elementName
  }
  
  func parser(_ parser: XMLParser, foundCharacters: String) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
    
    if (episodes.count != 0 && foundCharacters != "\n\t\t\t") {
      switch (currentElement) {
        case "title":
          episodes[episodes.endIndex - 1].title += foundCharacters
          break
        case "description":
          episodes[episodes.endIndex - 1].description += foundCharacters
          break
        case "pubDate":
          if let formattedDate = dateFormatter.date(from: foundCharacters) {
            episodes[episodes.endIndex - 1].pubDate = formattedDate
          }
          break
        default:
          break
      }
    }
  }
  
  func parserDidEndDocument(_ parser: XMLParser) {
    if let finishHandler = handler {
      finishHandler(episodes)
    }
  }
}
