//
//  ImageCollectionViewCell.swift
//  Screenshot Organizer
//
//  Created by Emad Beyrami on 1/24/1400 AP.
//

import UIKit
import Photos

class ImageCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    /// LifeCycle
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.addSubview(imageView)
        imageView.fillSuperView(padding: 5)
        self.sizeToFit()
    }
    
    /// Image Setter
    public func setImage(image: PhotoModel) {
        imageView.image = image.photo.convertBase64StringToImage()
    }
    
}

//MARK: - Identifier Handler
extension ImageCollectionViewCell: ReusableView { }
