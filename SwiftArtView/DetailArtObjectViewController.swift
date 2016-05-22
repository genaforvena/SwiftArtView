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
        descriptionLabel.text = artObject.description
        addressLabel.text = artObject.location!.address
    }
}