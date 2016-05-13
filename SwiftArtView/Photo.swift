//
//  Photo.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/13/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import Foundation
import Decodable

struct Photo {
    let name: String?
    let url: String?
}

extension Photo : Decodable {
    static func decode(j: AnyObject) throws -> Photo {
        return try Photo(
            name: j =>? "name",
            url: j =>? "image"
        )
    }
}