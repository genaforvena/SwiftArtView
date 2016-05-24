//
//  DetailArtObjectViewController.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/13/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import UIKit
import MapKit
import AlamofireImage

class DetailArtObjectViewController : UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var favouriteButton: FavoriteButton!
    
    var artObject: ArtworkRealm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        titleLabel.text = artObject.name
        authorLabel.text = artObject.authors
        if artObject.description.isEmpty {
            descriptionLabel.hidden = true
        } else {
            descriptionLabel.text = artObject.desc
        }
        addressLabel.text = artObject.address
        
        if (artObject.favourite) {
            favouriteButton.selected = true
        } else {
            favouriteButton.selected = false
        }
        favouriteButton.addTarget(self, action: #selector(favouriteButtonPressed), forControlEvents: .TouchUpInside)
        
        mapView.addAnnotation(ArtWorkAnnotation(artWork: artObject))
        mapView.scrollEnabled = false
        mapView.zoomEnabled = true
        centerMapOnLocation(mapView, location: CLLocation(latitude: artObject.lat, longitude: artObject.lng), regionRadius: 2000)
        
        let size = CGSize(width: imageView.bounds.width, height: imageView.bounds.height)
        imageView.af_setImageWithURL(
            NSURL(string: artObject.photoUrl)!,
            placeholderImage: UIImage(named: "Placeholder"),
            filter: AspectScaledToFillSizeFilter(size: size),
            imageTransition: .CrossDissolve(0.6)
        )
    }
    
    func favouriteButtonPressed(sender: FavoriteButton) {
        if sender.selected {
            ArtWorksStorage.instance.setFavourite(artObject.id, isFavourite: true)
            sender.deselect()
        } else {
            ArtWorksStorage.instance.setFavourite(artObject.id, isFavourite: false)
            sender.select()
        }
    }
}