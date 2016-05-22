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
    
    override func awakeFromNib() {
        layer.masksToBounds = false
        layer.borderWidth = 0.5
        layer.cornerRadius = 3
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureWithArtWork(artWork: ArtworkRealm) {
        self.artWork = artWork
        
        nameLabel.text = artWork.name
        
//        guard let url = artWork.photos[0].url else {
//            return
//        }
//        let size = CGSize(width: image.bounds.width, height: image.bounds.height)
//        image.af_setImageWithURL(
//            NSURL.fileURLWithPath(url),
//            placeholderImage: UIImage(named: "Placeholder"),
//            filter: AspectScaledToFillSizeFilter(size: size),
//            imageTransition: .CrossDissolve(0.6)
//        )
    }

}