//
//  ProductCellView.swift
//  LiverSearch
//
//  Created by Axel Iván Solano González on 05/07/21.
//

import UIKit

class ProductCellView: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    func setData(name:String, price:Double, imageString:String){
        productName.text=name
        productPrice.text=String(price)
        let imageURL:URL = URL(string: imageString)!
        productImage.load(url: imageURL)
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
