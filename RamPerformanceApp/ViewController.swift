//
//  ViewController.swift
//  RamPerformanceApp
//
//  Created by Ferhan Akkan on 20.07.2023.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var imageViewMountain: UIImageView!
    @IBOutlet private weak var imageViewEye: UIImageView!

    private let imageConverter = ImageIOConverter()
    private let renderType: ImageRenderType = .resized

    override func viewDidLoad() {
        super.viewDidLoad()

        switch renderType {
        case .traditional:
            imageViewMountain.image = UIImage(named: "mountain")
            imageViewEye.image = UIImage(named: "eye")
        case .resized:
            setConvertedImage(name: "mountain", imageView: imageViewMountain)
            setConvertedImage(name: "eye", imageView: imageViewEye)
        }
    }
}

private extension ViewController {
    func setConvertedImage(name: String, imageView: UIImageView) {
        guard let imageData = UIImage(named: name)?.jpegData(compressionQuality: 1) else { return }
        let maxPixelSize = getRequiredMaxPixelSize(view: imageView)
        imageConverter.resize(imageData: imageData, maxPixelSize: maxPixelSize) { image in
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }

    func getRequiredMaxPixelSize(view: UIView) -> Int {
        let height = Int(view.frame.height)
        let width = Int(view.frame.width)
        let maxPixelSize = height >= width
        ? height
        : width
        return maxPixelSize
    }
}
