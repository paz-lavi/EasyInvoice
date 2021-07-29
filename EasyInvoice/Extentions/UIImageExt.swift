//
//  UIImageExt.swift
//  EasyInvoice
//
//  Created by Paz Lavi  on 24/07/2021.
//

import Foundation
import  UIKit
import SDWebImage

extension UIImageView{
    // no cache
    func setImage(from url: String) {
        let ph = UIImage(named: "img")
        self.image = ph
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let _image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = _image
            }
        }
    }
    // cache
    func setNetworkImage(from url: String) {
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "img"))
    }
}
