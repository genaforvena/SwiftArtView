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
    
    func listenChanges(block: NotificationBlock) -> NotificationToken {
        return realm.addNotificationBlock(block)
    }
    
    func listArtWorks() -> Results<ArtworkRealm> {
        return realm.objects(ArtworkRealm).sorted("updatedAt", ascending: false)
    }
    
    func listFavourites() -> Results<ArtworkRealm> {
        return realm.objects(ArtworkRealm).sorted("updatedAt", ascending: false).filter("favourite == true")
    }
    
    func setFavourite(artwork: ArtworkRealm, isFavourite: Bool) {
        print("Setting favourite for " + artwork.id)
        try! realm.write {
            artwork.favourite = isFavourite
        }
    }
    
    func insertArtworks(artworks: [ArtWork]) {
        realm.beginWrite()
        
        for artwork in artworks {
            let realmArtwork = ArtworkRealm()
            realmArtwork.id = artwork.id
            realmArtwork.name = artwork.name
            realmArtwork.desc = artwork.description
            realmArtwork.updatedAt = artwork.updatedAt
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
            
            guard let objectWas = realm.objects(ArtworkRealm.self).filter("id = %@", artwork.id).first else {
                realm.add(realmArtwork, update: true)
                continue
            }
            
            realmArtwork.favourite = objectWas.favourite
            realm.add(realmArtwork, update: true)
        }
    
        try! realm.commitWrite()
    }
    
}