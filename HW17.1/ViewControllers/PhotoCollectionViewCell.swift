//
//  CollectionViewCell.swift
//  HW17.1
//
//  Created by Sharipov Mehrob on 17.07.2023.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    let imageArray = ImageSliderModel.shared.saveImageArray()
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = contentView.frame
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configCell(indexPath: IndexPath?){
        if let index = indexPath?.item {
            if let imageName = self.imageArray[safe:index]?.name {
                DispatchQueue.global().async {
                    let loadImage = ImageManager.shared.loadImage(fileName: imageName)
                    
                    DispatchQueue.main.async {
                        self.imageView.image = loadImage
                    }
                }
            }
        }
    }
    
}


