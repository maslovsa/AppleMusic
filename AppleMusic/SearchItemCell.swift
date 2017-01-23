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
    static let CellHeight = 100
    
    var searchItem: SearchItem!
    
    fileprivate var artistName = UILabel()
    fileprivate var collectionName = UILabel()
    fileprivate var trackName = UILabel()
    fileprivate var artwork = UIImageView()
    //    var artistName: String = ""
    //    var collectionName: String = ""
    //    var trackName: String = ""
    //    var artworkUrl100: String = ""
    fileprivate let cornerRadius: CGFloat = 10
    
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
            make.width.height.equalTo(40)
        }
        
        artistName.textAlignment = .left
        artistName.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightRegular)
        artistName.lineBreakMode = .byTruncatingTail
        artistName.textColor = UIColor.gray
        artistName.backgroundColor = UIColor.clear
        addSubview(artistName)
        artistName.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(50)
            make.top.equalTo(self).offset(8)
            make.right.equalTo(self)
        }
        
    }
    
    func configure(_ searchItem: SearchItem) {
        self.searchItem = searchItem
        
        if let imageUrl = searchItem.artworkUrl100 {
            artwork.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage.stubImage)
        }
        
        artistName.text = searchItem.artistName
    }
}
