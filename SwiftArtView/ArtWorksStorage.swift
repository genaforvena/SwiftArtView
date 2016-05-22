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
        
        for artwork in artworks {
            let realmArtwork = ArtworkRealm()
            realmArtwork.id = artwork.id
            realmArtwork.name = artwork.name
            realmArtwork.desc = artwork.description
            
            let realmLocation = LocationRealm()
            realmLocation.address = artwork.location.address
            realmLocation.lat = artwork.location.lat
            realmLocation.lng = artwork.location.lng
            
            realmArtwork.location = realmLocation
            
            if artwork.photos.count > 0 {
                for photo in artwork.photos {
                    guard let name = photo.name else { continue }
                    guard let url = photo.url else { continue }
                    
                    let realmPhoto = PhotoRealm()
                    realmPhoto.name = name
                    realmPhoto.url = url
                    realmArtwork.photos.append(realmPhoto)
                }
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