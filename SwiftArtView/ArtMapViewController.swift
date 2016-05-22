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

class ArtMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    let regionRadius : Double = 6000
    
    var artWorks: Results<ArtworkRealm>! {
        didSet {
            artWorks.forEach { artwork in
                mapView.addAnnotation(ArtWorkAnnotation(artWork: artwork))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(mapView, location: nizhnyNovgorod, regionRadius: regionRadius)
        mapView.delegate = self
        fetchArtWorks()
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ArtWorkAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.init(type: .DetailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        if control == view.rightCalloutAccessoryView {
            performSegueWithIdentifier("DetailArtObjectFromMap", sender: view)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailArtObjectFromMap" {
            let destinationController = segue.destinationViewController as! DetailArtObjectViewController
            destinationController.hidesBottomBarWhenPushed = true
            destinationController.artObject = ((sender as! MKAnnotationView).annotation as! ArtWorkAnnotation).artwork
        }
    }
    
    func fetchArtWorks() {
        self.artWorks = ArtWorksStorage.instance.listArtWorks()
    }
}

func centerMapOnLocation(mapView: MKMapView, location: CLLocation, regionRadius: Double) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                              regionRadius * 2.0, regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
}
