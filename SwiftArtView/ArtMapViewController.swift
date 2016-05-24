//
//  FirstViewController.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/12/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

let nizhnyNovgorod = CLLocation(latitude: 56.327530, longitude: 44.000717)

class ArtMapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    let regionRadius : Double = 6000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        let locationMgr = CLLocationManager.init()
        locationMgr.requestAlwaysAuthorization()
        
        centerMapOnLocation(mapView, location: nizhnyNovgorod, regionRadius: regionRadius)
        mapView.showsUserLocation = true
        mapView.scrollEnabled = true
        mapView.zoomEnabled = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailArtObjectFromMap" {
            let destinationController = segue.destinationViewController as! DetailArtObjectViewController
            destinationController.hidesBottomBarWhenPushed = true
            destinationController.artObject = ((sender as! MKAnnotationView).annotation as! ArtWorkAnnotation).artwork
        }
    }
}

extension ArtMapViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        if control == view.rightCalloutAccessoryView {
            performSegueWithIdentifier("DetailArtObjectFromMap", sender: view)
        }
    }
}

func centerMapOnLocation(mapView: MKMapView, location: CLLocation, regionRadius: Double) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                              regionRadius * 2.0, regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
}
