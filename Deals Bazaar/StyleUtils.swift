//
//  ColorUtils.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 05/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit

/*
 <color name="colorPrimary">#F44336</color>
 <color name="colorPrimaryDark">#D32F2F</color>
 <color name="colorPrimaryMiddle">#D32F2F</color>
 <color name="colorAccent">#03A9F4</color>
 <color name="colorAccentDark">#0288d1</color>
 <color name="colorAccentTP">#990288d1</color>
 */

extension UIImage {
    class func imageWithLayer(layer: CAGradientLayer) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.isOpaque, 0.0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}


extension UIColor{
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    class func primaryColor()->UIColor{
        return UIColor(rgb:0xF44336)
    }
    
    class func primaryDarkColor()->UIColor{
        return UIColor(rgb:0xD32F2F)
    }
    
    class func primaryMiddleColor()->UIColor{
        return UIColor(rgb:0xD32F2F)
    }
    
    class func accentColor()->UIColor{
        return UIColor(rgb:0x03A9F4)
    }
    
    class func accentColorDark()->UIColor{
        return UIColor(rgb:0x0288d1)
    }
    
    class func grayLightBgColor()->UIColor{
        return UIColor(rgb:0xcccccc)
    }
    

}

extension UIFont{
    
    class func poppins(type:String, size:CGFloat)->UIFont{
        return UIFont(name:"Poppins-\(type)", size:CGFloat(size))!
    }
    
    class func quicksand(type:String, size:CGFloat)->UIFont{
        return UIFont(name:"Quicksand-\(type)", size:CGFloat(size))!
    }

}


extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}






