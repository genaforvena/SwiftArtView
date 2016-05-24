//
//  ArtworkRealm.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/22/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import Foundation
import RealmSwift

class ArtworkRealm : Object {
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var desc: String?
    dynamic var lat: Double = 0.0
    dynamic var lng: Double = 0.0
    dynamic var address: String = ""
    dynamic var authors: String = ""
    let photos = List<PhotoRealm>()
    dynamic var favourite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}