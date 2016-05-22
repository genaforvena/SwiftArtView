//
//  ArtWorksStorage.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/22/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import Foundation
import RealmSwift

class ArtWorksStorage {
    static let instance = ArtWorksStorage()
    let realm = try! Realm()
    
    func listArtWorks() -> Results<ArtworkRealm> {
        return realm.objects(ArtworkRealm)
    }
    
    func insertArtworks(artworks: [ArtWork]) {
        realm.beginWrite()
        artworks.forEach { artwork in
            let realmArtwork = ArtworkRealm()
            realmArtwork.id = artwork.id
            realmArtwork.name = artwork.name
            realmArtwork.desc = artwork.description
            
            let realmLocation = LocationRealm()
            realmLocation.address = artwork.location.address
            realmLocation.lat = artwork.location.lat
            realmLocation.lng = artwork.location.lng
            
            realmArtwork.location = realmLocation
            
            realm.add(realmArtwork, update: true)
        }
    
        try! realm.commitWrite()
    }
    
}