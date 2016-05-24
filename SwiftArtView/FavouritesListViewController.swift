//
//  FavouritesListViewController.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/24/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import Foundation
import RealmSwift

class FavouritesViewController: ArtListViewController {
    override func performFetch() -> Results<ArtworkRealm> {
        return ArtWorksStorage.instance.listFavourites()
    }
}