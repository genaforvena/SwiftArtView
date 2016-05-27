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

class DetailArtObjectViewController : UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var favouriteButton: FavoriteButton!
    
    @IBOutlet weak var distanceToLabel: UILabel!
    
    @IBOutlet weak var addressButton: UIButton!
    
    var artObject: ArtworkRealm!
    
    let locationManager = CLLocationManager.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    
        titleLabel.text = artObject.name
        authorLabel.text = artObject.authors
        if artObject.description.isEmpty {
            descriptionLabel.hidden = true
        } else {
            descriptionLabel.text = artObject.desc
        }
        addressButton.setTitle(artObject.address, forState: .Normal)
        
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
    
    @IBAction func navigateTo(sender: UIButton) {
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
            UIApplication.sharedApplication().openURL(NSURL(string:
                "comgooglemaps://?center=\(artObject.lat),\(artObject.lng)&zoom=14")!)
        } else {
            print("Can't use comgooglemaps://");
        }
    }
    
    @IBAction func share(sender: UIButton) {
        let textToShare = "\(artObject.name) \n\(artObject.address)"
        
        // TODO share image also
        let objectsToShare = [textToShare]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
        activityVC.popoverPresentationController?.sourceView = sender
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    func favouriteButtonPressed(sender: FavoriteButton) {
        if sender.selected {
            ArtWorksStorage.instance.setFavourite(artObject, isFavourite: false)
            sender.deselect()
        } else {
            ArtWorksStorage.instance.setFavourite(artObject, isFavourite: true)
            sender.select()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = manager.location else {
            print("Unable to get user location")
            return
        }
        distanceToLabel.text = String(locValue.distanceFromLocation(CLLocation(latitude: artObject.lat, longitude: artObject.lng)))
    }
}
