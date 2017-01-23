//
//  UIImage+Color.swift
//  AppleMusic
//
//  Created by Maslov Sergey on 23.01.17.
//  Copyright © 2017 Maslov Sergey. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    
    static var stubImage: UIImage {
        return self.imageWithColor(color: UIColor.darkGray)
    }
}
