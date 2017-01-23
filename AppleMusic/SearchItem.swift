//
//  SearchItem.swift
//  AppleMusic
//
//  Created by Maslov Sergey on 23.01.17.
//  Copyright © 2017 Maslov Sergey. All rights reserved.
//

import Foundation

//- В ячейках отображается имя артиста, название альбома и название песни, картинка artwork.
struct SearchItem {
    var artistName: String = ""
    var collectionName: String = ""
    var trackName: String = ""
    var artworkUrl100: String? = nil
    var releaseDate: String? = nil
    var primaryGenreName: String? = nil
    
    static func JJ1() -> SearchItem {
        return SearchItem(artistName: "Jack Johnson",
                          collectionName: "In Between Dreams",
        trackName:"Better Together",
        artworkUrl100: "http://is3.mzstatic.com/image/thumb/Music2/v4/a2/66/32/a2663205-663c-8301-eec7-57937c2d0878/source/100x100bb.jpg",
        releaseDate: "2005-03-01T08:00:00Z",
        primaryGenreName: "Rock")
    }
}
