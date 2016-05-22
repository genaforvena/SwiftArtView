//
//  LocationRealm.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/22/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import Foundation
import RealmSwift

class LocationRealm: Object {
    dynamic var lat: Double = 0.0
    dynamic var lng: Double = 0.0
    dynamic var address: String = ""
}