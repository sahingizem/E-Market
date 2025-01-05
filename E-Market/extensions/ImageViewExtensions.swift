//
//  ImageViewExtensions.swift
//  E-Market
//
//  Created by gizem on 6.01.2025.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
