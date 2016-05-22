//
//  Author.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/22/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import Foundation
import Decodable

struct Author {
    let id: String
    let name: String
}

extension Author : Decodable {
    static func decode(j: AnyObject) throws -> Author {
        return try Author(
            id: j => "id",
            name: j => "name"
        )
    }
}