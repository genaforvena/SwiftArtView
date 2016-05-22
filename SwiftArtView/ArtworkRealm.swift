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
    dynamic var location: LocationRealm?
    let photos = List<PhotoRealm>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}