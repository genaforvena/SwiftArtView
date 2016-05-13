//
//  SecondViewController.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/12/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import UIKit

class ArtListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    static let emptyFooterReusableID = "EmptyFooter"
    
    var artWorks: [ArtWork] = [] {
        didSet {
            self.collectionView!.reloadData()
        }
    }
    
    var refreshControl: UIRefreshControl?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the refresh control.
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(ArtListViewController.fetchArtWorks), forControlEvents: .ValueChanged)
        collectionView!.addSubview(refreshControl!)
        
        collectionView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: ArtListViewController.emptyFooterReusableID)
        
        collectionView!.delegate = self
        
        // Fetch friends and favorite products from the API.
        fetchArtWorks()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchArtWorks()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artWorks.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(ArtObjectCell.reuseIdentifier, forIndexPath: indexPath)
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let cell = cell as! ArtObjectCell
        let artWork = artWorks[indexPath.row]
        cell.configureWithArtWork(artWork)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset.left
        let width = (view.bounds.width - 3 * spacing) / 2
        return CGSize(width: width, height: width + 50)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    // MARK: UIStoryboardSegue Handling
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let artWorkCell = sender as! ArtObjectCell
        
        // TODO
//        let productDetailViewController = segue.destinationViewController as! ProductDetailViewController
//        productDetailViewController.product = productCell.product
    }
    
    // MARK: API
    
    // We need to upload the contacts before this.
    func fetchArtWorks() {
        self.refreshControl!.beginRefreshing()
        StreetArtViewAPI.sharedInstance.getArtWorksList() { artWorks in
            self.artWorks = artWorks
            self.refreshControl!.endRefreshing()
        }
    }
}

