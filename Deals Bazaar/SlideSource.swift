//
//  SlideSource.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 08/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import ImageSlideshow
import Kingfisher
import UIKit

/// Input Source to image using Kingfisher
public class SlideSource: NSObject, InputSource {
    
    /// url to load
    public var url: URL
    
    /// placeholder used before image is loaded
    public var placeholder: UIImage?
    
    var slide:Slide?

    
    /// Inits with Slide as source
    /// - parameter slide: Slide Object
    /// - parameter placeholder: a placeholder used before image is loaded
    convenience init?(url:String, slide:Slide ,placeholder:UIImage? = nil){
         self.init(urlString: url,placeholder: placeholder)
         self.slide = slide
    }
    
  
    /// Initializes a new source with a URL string
    /// - parameter urlString: a string url to load
    /// - parameter placeholder: a placeholder used before image is loaded
    public init?(urlString: String, placeholder: UIImage? = nil) {
        if let validUrl = URL(string: urlString.trimmingCharacters(in: .whitespacesAndNewlines)) {
            self.url = validUrl
            self.placeholder = placeholder
            super.init()
        } else {
            let fallbackURL = URL(string:"http://wiseburnedfoundation.org/wp-content/themes/nevia/images/shop-01.jpg")!
            self.url = fallbackURL
            self.placeholder = placeholder
            super.init()
        }
    }
    
    @objc public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        let processor = ResizingImageProcessor(referenceSize: CGSize(width: imageView.frame.width, height: imageView.frame.height))
        imageView.kf.setImage(with: self.url, placeholder: self.placeholder, options: [.processor(processor)], progressBlock: nil) { (image, _, _, _) in
            callback(image)
        }
    }

    
    
}
