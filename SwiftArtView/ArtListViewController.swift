//
//  SecondViewController.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/12/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import UIKit
import RealmSwift

class ArtListViewController: UICollectionViewController {
    
    // MARK: Properties
    static let emptyFooterReusableID = "EmptyFooter"
    
    var artWorks: Results<ArtworkRealm>! {
        didSet {
            self.collectionView!.reloadData()
        }
    }
    
    var refreshControl: UIRefreshControl?
    var realmToken: NotificationToken?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the refresh control.
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(ArtListViewController.refetchArtWorks), forControlEvents: .ValueChanged)
        collectionView!.addSubview(refreshControl!)
        
        collectionView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: ArtListViewController.emptyFooterReusableID)
        collectionView!.delegate = self
        
        realmToken = ArtWorksStorage.instance.listenChanges { notifcation, block in
            print("Realm has changed. Refetching objects.")
            self.fetchArtWorks()
        }
        
        fetchArtWorks()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchArtWorks()
    }
    
    deinit {
        realmToken?.stop()
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
    
    // MARK: UIStoryboardSegue Handling
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let artWorkCell = sender as! ArtObjectCell
        
        let artObjectDetailViewController = segue.destinationViewController as! DetailArtObjectViewController
        artObjectDetailViewController.hidesBottomBarWhenPushed = true
        artObjectDetailViewController.artObject = artWorkCell.artWork
    }
    
    // MARK: API
    
    func fetchArtWorks() {
        self.refreshControl!.beginRefreshing()
        self.artWorks = performFetch()
        self.refreshControl!.endRefreshing()
    }
    
    func performFetch() -> Results<ArtworkRealm> {
        return ArtWorksStorage.instance.listArtWorks()
    }
    
    func refetchArtWorks() {
        ArtFetcher.instance.fetchAndStoreArtworks {
            self.artWorks = self.performFetch()
            self.refreshControl!.endRefreshing()
        }
    }
}

extension ArtListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (view.bounds.width - 3) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
}

