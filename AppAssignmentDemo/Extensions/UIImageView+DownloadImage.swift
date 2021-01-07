//
//  UIImageView+DownloadImage.swift
//  AppAssignmentDemo
//
//  Created by Piyush Naredi on 07/01/21.
//

import UIKit
import AlamofireImage

/// A extension of UIImage for Download and resize image.
extension UIImageView {
    
    /**
     A method to download image.
     
     - parameter imageURL: A URL string for Image.
     - parameter placeholderImage: A UIImage for placeholder.
     */
    func downloadImage(imageURL: String?, placeholderImage: UIImage? = nil) {
        if let imageurlStr = imageURL, let imgUrl = URL(string: imageurlStr) {
            self.af.setImage(withURL: imgUrl, placeholderImage: placeholderImage, completion:  {(imageResult) in
                switch imageResult.result {
                case .success(let img):
                    self.image = img.resizeImageWith(newSize: self.frame.size)
                    self.contentMode = .scaleAspectFill
                case .failure(let error):
                    debugPrint("An Error occured while downloading image: \(error.localizedDescription)")
                    break
                }
            })
        } else {
            self.image = placeholderImage
        }
    }
}

extension UIImage {

    /**
     A method to resize image.
     - parameter newSize: A new value of CGSize .
     - returns: A resized UIImage.
     */

    func resizeImageWith(newSize: CGSize) -> UIImage {

        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height

        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)

        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
