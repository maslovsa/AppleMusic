//
//  SearchItemCell.swift
//  AppleMusic
//
//  Created by Maslov Sergey on 23.01.17.
//  Copyright © 2017 Maslov Sergey. All rights reserved.
//

import UIKit
import SDWebImage

class SearchItemCell: UITableViewCell {
    static let Identifier = "SearchItemCell"
    static let CellHeight = 60 + 8 + 8
    
    var searchItem: SearchItem!
    
    fileprivate var artistName = UILabel()
    fileprivate var collectionName = UILabel()
    fileprivate var trackName = UILabel()
    fileprivate var artwork = UIImageView()
    fileprivate let cornerRadius: CGFloat = 10
    fileprivate let artistNameTextLeftOffset = 76
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        localInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        localInit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        localInit()
    }
    
    func localInit() {
        artwork.contentMode = .scaleAspectFit
        artwork.layer.cornerRadius = cornerRadius
        artwork.layer.masksToBounds = true
        addSubview(artwork)
        artwork.snp.makeConstraints { (make) -> Void in
            make.top.left.equalTo(self).offset(8)
            make.width.height.equalTo(60)
        }
        
        artistName.textAlignment = .left
        artistName.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightRegular)
        artistName.lineBreakMode = .byTruncatingTail
        artistName.textColor = UIColor.black
        artistName.backgroundColor = UIColor.clear
        addSubview(artistName)
        artistName.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(artistNameTextLeftOffset)
            make.top.equalTo(self).offset(8)
            make.right.equalTo(self)
        }
        
        collectionName.textAlignment = .left
        collectionName.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightRegular)
        collectionName.lineBreakMode = .byTruncatingTail
        collectionName.textColor = UIColor.darkGray
        collectionName.backgroundColor = UIColor.clear
        addSubview(collectionName)
        collectionName.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(artistNameTextLeftOffset)
            make.top.equalTo(self).offset(30)
            make.right.equalTo(self)
        }
        
        trackName.textAlignment = .left
        trackName.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightRegular)
        trackName.lineBreakMode = .byTruncatingTail
        trackName.textColor = UIColor.gray
        trackName.backgroundColor = UIColor.clear
        addSubview(trackName)
        trackName.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(artistNameTextLeftOffset)
            make.top.equalTo(self).offset(50)
            make.right.equalTo(self)
        }
    }
    
    func configure(_ searchItem: SearchItem) {
        self.searchItem = searchItem
        
        if let imageUrl = searchItem.artworkUrl100 {
            artwork.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage.stubImage)
        }
        
        artistName.text = searchItem.artistName
        collectionName.text = searchItem.collectionName
        trackName.text = searchItem.trackName
    }
}
