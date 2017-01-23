//
//  DetailItemViewController.swift
//  AppleMusic
//
//  Created by Maslov Sergey on 23.01.17.
//  Copyright © 2017 Maslov Sergey. All rights reserved.
//

import UIKit
import SnapKit

class DetailItemViewController: UIViewController {
    var searchItem: SearchItem!
    
    fileprivate var releaseDate = UILabel()
    fileprivate var primaryGenreName = UILabel()
    fileprivate var artwork = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        artwork.contentMode = .scaleAspectFit
        artwork.layer.masksToBounds = true
        view.addSubview(artwork)
        artwork.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(view)
            make.width.height.equalTo(view)
        }
        
        releaseDate.textAlignment = .left
        releaseDate.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        releaseDate.lineBreakMode = .byTruncatingTail
        releaseDate.textColor = UIColor.black
        releaseDate.backgroundColor = UIColor.clear
        view.addSubview(releaseDate)
        releaseDate.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(66)
        }
        
        primaryGenreName.textAlignment = .left
        primaryGenreName.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        primaryGenreName.lineBreakMode = .byTruncatingTail
        primaryGenreName.textColor = UIColor.black
        primaryGenreName.backgroundColor = UIColor.clear
        view.addSubview(primaryGenreName)
        primaryGenreName.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(86)
        }
        
        udpateContent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func udpateContent() {
        if let imageUrl = searchItem.artworkUrl100 {
            artwork.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage.stubImage)
        }
        
        if let date = searchItem.releaseDate {
            releaseDate.text = "Release Date: \(date)"
        }

        if let genre = searchItem.primaryGenreName {
            primaryGenreName.text = "Genre: \(genre)"
        }
    }
}

