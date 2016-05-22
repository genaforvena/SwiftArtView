//
//  ArtFetcher.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/22/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import Foundation

class ArtFetcher {
    static let instance = ArtFetcher()
    
    func fetchAndStoreArtworks(completion: () -> Void = { }) {
        StreetArtViewAPI.sharedInstance.getArtWorksList { artworks in
            ArtWorksStorage.instance.insertArtworks(artworks)
            completion()
        }
    }
    
}