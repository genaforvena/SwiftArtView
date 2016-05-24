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
    
    func listFavourites() -> Results<ArtworkRealm> {
        return realm.objects(ArtworkRealm).filter("favourite == true")
    }
    
    func setFavourite(artworkId: String, isFavourite: Bool) {
        try! realm.write {
            realm.create(ArtworkRealm.self, value: ["id": artworkId, "favourite": isFavourite], update: true)
        }
    }
    
    func insertArtworks(artworks: [ArtWork]) {
        realm.beginWrite()
        
        for artwork in artworks {
            let realmArtwork = ArtworkRealm()
            realmArtwork.id = artwork.id
            realmArtwork.name = artwork.name
            realmArtwork.desc = artwork.description
            
            realmArtwork.address = artwork.location.address
            realmArtwork.lat = artwork.location.lat
            realmArtwork.lng = artwork.location.lng
            
            if artwork.photos.count > 0 {
                let photo = artwork.photos[0]
                guard let url = photo.url else { continue }
                realmArtwork.photoUrl = url
            }
            
            if artwork.authors.count > 0 {
                let authors = artwork.authors.map{ author in author.name}.joinWithSeparator(", ")
                realmArtwork.authors = authors
            }
            
            realm.add(realmArtwork, update: true)
        }
    
        try! realm.commitWrite()
    }
    
}