//
//  PhotoRealm.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/22/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoRealm: Object {
    dynamic var name: String = ""
    dynamic var url: String = ""
}