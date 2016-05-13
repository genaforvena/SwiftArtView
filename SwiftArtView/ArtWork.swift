//
//  ArtWork.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/13/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import Foundation
import Decodable

struct ArtWork {
    let id: String
    let name: String
    let description: String
    let location: Location
    let photos: [Photo]
}

extension ArtWork : Decodable {
    static func decode(j: AnyObject) throws -> ArtWork {
        return try ArtWork(
            id: j => "id",
            name: j => "name",
            description: j => "description",
            location: j => "location",
            photos: j => "photos" as [Photo]
        )
    }
}