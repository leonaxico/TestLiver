//
//  ProductCell.swift
//  LiverSearch
//
//  Created by Axel Iván Solano González on 05/07/21.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    static let identifier = "productCell"
    
    private let myImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel:UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.backgroundColor = UIColor.systemPink
        contentView.addSubview(myImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 5, y: contentView.frame.height - 25, width: contentView.frame.width - 10, height: 25)
        
        priceLabel.frame = CGRect(x: 5, y: contentView.frame.height - 50, width: contentView.frame.width - 10, height: 25)
        
        myImageView.frame = CGRect(x: 5, y: 0, width: contentView.frame.width - 10, height: contentView.frame.height - 50)

    }
    
    public func configure(name:String, price:Double, image: String){
        nameLabel.text=name
        priceLabel.text=String(price)
        setImage(from: image)
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.myImageView.image = image
            }
        }
    }
}
