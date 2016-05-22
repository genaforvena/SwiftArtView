//
//  ArtObjectCell.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/13/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import UIKit
import AlamofireImage

final class ArtObjectCell : UICollectionViewCell {
    static let reuseIdentifier = "ArtObjectCell"
    
    var artWork: ArtworkRealm!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureWithArtWork(artWork: ArtworkRealm) {
        self.artWork = artWork
        
        nameLabel.text = artWork.name
        
        if artWork.photos.count > 0 {
            let url = artWork.photos[0].url
            
            let size = CGSize(width: image.bounds.width, height: image.bounds.height)
            image.af_setImageWithURL(
                NSURL(string: url)!,
                placeholderImage: UIImage(named: "Placeholder"),
                filter: AspectScaledToFillSizeFilter(size: size),
                imageTransition: .CrossDissolve(0.6)
            )
        }
    }

}