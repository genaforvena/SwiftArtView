//
//  ArtWorkAnnotation.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/22/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import Foundation
import MapKit

class ArtWorkAnnotation : NSObject, MKAnnotation {
    let artwork: ArtworkRealm!
    
    init(artWork: ArtworkRealm) {
        self.artwork = artWork
        coordinate = CLLocationCoordinate2D.init(latitude: artWork.location!.lat, longitude: artWork.location!.lng)
        title = artWork.name
    }
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
}