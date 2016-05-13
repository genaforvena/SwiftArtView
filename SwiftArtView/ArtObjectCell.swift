//
//  ArtObjectCell.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/13/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import UIKit

final class ArtObjectCell : UICollectionViewCell {
    static let reuseIdentifier = "ArtObjectCell"
    
    var artWork: ArtWork!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        layer.masksToBounds = false
        layer.borderWidth = 0.5
        layer.cornerRadius = 3
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureWithArtWork(artWork: ArtWork) {
        self.artWork = artWork
        
        nameLabel.text = artWork.name
        
//        let size = CGSize(width: imageView.bounds.width, height: imageView.bounds.height)
//        imageView.af_setImageWithURL(
//            product.imageURL,
//            placeholderImage: UIImage(named: "Placeholder"),
//            filter: AspectScaledToFillSizeFilter(size: size),
//            imageTransition: .CrossDissolve(0.6)
//        )
    }

}