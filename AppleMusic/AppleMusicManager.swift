//
//  AppleMusicManager.swift
//  AppleMusic
//
//  Created by Maslov Sergey on 23.01.17.
//  Copyright © 2017 Maslov Sergey. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public typealias SearchResults = (_ items: [SearchItem]?) -> ()

public protocol Searchable {
    func search(query: String, completion: @escaping SearchResults)
    var searchResults: [SearchItem] { get }
}

class AppleMusicManager: Searchable {
    public var searchResults: [SearchItem] = []
    private let searchLimit = 10
    private let URL_PATTERN = "https://itunes.apple.com/search?term=%@&limit=%d"
    
    func search(query: String, completion: @escaping SearchResults) {
        guard let path = getPath(query) else {
            completion(nil)
            return
        }
        
        Alamofire.request(path).validate().responseJSON {response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                let newLinks = json["results"].arrayValue
                self.searchResults = [SearchItem]()
                for link in newLinks {
                    var item = SearchItem()
                    if let artistName = link["artistName"].string {
                        item.artistName = artistName
                    }
                    if let collectionName = link["collectionName"].string {
                        item.collectionName = collectionName
                    }
                    if let trackName = link["trackName"].string {
                        item.trackName = trackName
                    }
                    if let artworkUrl100 = link["artworkUrl100"].string {
                        item.artworkUrl100 = artworkUrl100
                    }
                    if let releaseDate = link["releaseDate"].string {
                        item.releaseDate = releaseDate
                    }
                    if let primaryGenreName = link["primaryGenreName"].string {
                        item.primaryGenreName = primaryGenreName
                    }
                    self.searchResults.append(item)
                }
                
                completion(self.searchResults)
                
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    private func getPath(_ query: String) -> String? {
        if query.characters.count > 0 {
            return String.init(format: URL_PATTERN, query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, searchLimit)
        } else {
            return nil
        }
    }
}
