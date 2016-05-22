//
//  DetailArtObjectViewController.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/13/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import UIKit
import MapKit

class DetailArtObjectViewController : UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
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
        addressLabel.text = artObject.location!.address
        
        mapView.addAnnotation(ArtWorkAnnotation(artWork: artObject))
        centerMapOnLocation(mapView, location: CLLocation(latitude: artObject.location!.lat, longitude: artObject.location!.lng), regionRadius: 2000)
    }
}