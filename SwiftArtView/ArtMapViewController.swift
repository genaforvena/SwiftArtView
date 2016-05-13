//
//  FirstViewController.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/12/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import UIKit
import MapKit

class ArtMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    var artWorks: [ArtWork] = [] {
        didSet {
            artWorks.forEach { artwork in
                mapView.addAnnotation(ArtWorkAnnotation(artWork: artwork))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchArtWorks()
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ArtWorkAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
            }
            return view
        }
        return nil
    }
    
    // We need to upload the contacts before this.
    func fetchArtWorks() {
        StreetArtViewAPI.sharedInstance.getArtWorksList() { artWorks in
            self.artWorks = artWorks
        }
    }
}

class ArtWorkAnnotation : NSObject, MKAnnotation {
    init(artWork: ArtWork) {
        coordinate = CLLocationCoordinate2D.init(latitude: artWork.location.lat, longitude: artWork.location.lng)
        title = artWork.name
    }
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
}

