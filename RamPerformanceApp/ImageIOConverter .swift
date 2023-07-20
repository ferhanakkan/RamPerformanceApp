//
//  ImageIOConverter .swift
//  RamPerformanceApp
//
//  Created by Ferhan Akkan on 20.07.2023.
//

import Foundation.NSString
import ImageIO
import UIKit.UIImage

struct ImageIOConverter {

    func resize(
        imageData: Data,
        maxPixelSize: Int,
        completion: @escaping ((UIImage?) -> ())
    ) {
        DispatchQueue.global(qos: .background).async {
            guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, nil) else {
                completion(nil)
                return
            }

            let options: [NSString: Any] = [
                kCGImageSourceThumbnailMaxPixelSize: maxPixelSize,
                kCGImageSourceCreateThumbnailFromImageAlways: true
            ]

            guard let scaledImage = CGImageSourceCreateThumbnailAtIndex(
                imageSource,
                0,
                options as CFDictionary
            ) else {
                completion(nil)
                return
            }
            completion(UIImage(cgImage: scaledImage))
        }
    }
}
