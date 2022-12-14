//
//  UIImage+Ext.swift
//  CommunicationHelperApp
//
//  Created by 近藤宏輝 on 2022/10/21.
//

import UIKit

// https://dev.classmethod.jp/articles/swift-generate-qr-code/
extension UIImage {
    // QRコードの中をデザインするコード、現在は使っていない
    func composited(withSmallCenterImage centerImage: UIImage) -> UIImage {
        return UIGraphicsImageRenderer(size: self.size).image { context in
            let imageWidth = context.format.bounds.width
            let imageHeight = context.format.bounds.height
            let centerImageLength = imageWidth < imageHeight ? imageWidth / 5 : imageHeight / 5
            let centerImageRadius = centerImageLength * 0.2

            draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: context.format.bounds.size))
            let centerImageRect = CGRect(
                x: (imageWidth - centerImageLength) / 2,
                y: (imageHeight - centerImageLength) / 2,
                width: centerImageLength,
                height: centerImageLength
            )
            let roundedRectPath = UIBezierPath(roundedRect: centerImageRect, cornerRadius: centerImageRadius)
            roundedRectPath.addClip()
            centerImage.draw(in: centerImageRect)
        }
    }
}
