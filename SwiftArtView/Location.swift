//
//  Location.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/13/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import Foundation
import Decodable

struct Location {
    let lat: Double
    let lng: Double
    let address: String

}

extension Location : Decodable {
    static func decode(j: AnyObject) throws -> Location {
        return try Location(
            lat: j => "lat",
            lng: j => "lng",
            address: j => "address"
        )
    }
}