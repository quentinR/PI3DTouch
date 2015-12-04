//
//  PeekPopViewController.swift
//  PI3DTouch
//
//  Created by Quentin Ribierre on 11/28/15.
//  Copyright © 2015 Prolific Interactive Corp. All rights reserved.
//

import UIKit

class PeekPopViewController: UIViewController
{
    // MARK: - Constants
    
    private struct Constants {
        static let cellReuseIdentifier = "ImageCollectionViewCell"
        static let nbCellPerRow        = 3
        static let margin: CGFloat     = 2.0
    }

    //MARK: - Properties
    
    @IBOutlet private weak var collectionView: UICollectionView?
    
    lazy private var images: Array<Image> = {
        var images = Array<Image>()
        for (var id = 0; id <= 16; id++) {
            images.append(Image(id: id))
        }
        return images
    }()
    
    lazy var imageViewController: ImageViewController = {
        guard let imageViewController = self.storyboard?
            .instantiateViewControllerWithIdentifier("ImageViewController")
            as? ImageViewController
            else { return ImageViewController() }
        return imageViewController
    }()
    
    //MARK: - ViewController Lifecyle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.collectionView?.registerNib(UINib(nibName: Constants.cellReuseIdentifier, bundle: nil),
            forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
        
        if (traitCollection.forceTouchCapability == .Available) {
            if let collectionView = self.collectionView {
                registerForPreviewingWithDelegate(self, sourceView: collectionView)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
}

//MARK: - <UIViewControllerPreviewingDelegate>

extension PeekPopViewController: UIViewControllerPreviewingDelegate
{
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController?
    {
        guard let indexPath = collectionView?.indexPathForItemAtPoint(location) else { return nil }
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) else { return nil }
        previewingContext.sourceRect = cell.frame
        
        self.imageViewController.setupWithImage(self.images[indexPath.item])
        
        let preferedWidth = CGRectGetWidth(self.view.frame) - 50.0
        self.imageViewController.preferredContentSize = CGSize(width: preferedWidth, height: preferedWidth)
        
        return self.imageViewController
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController)
    {
        showViewController(self.imageViewController, sender: self)
    }
}

//MARK: - <UICollectionViewDataSource>

extension PeekPopViewController: UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath)
        -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.cellReuseIdentifier,
            forIndexPath: indexPath)
        guard let imageCell = cell as? ImageCollectionViewCell else { return cell }
        imageCell.setupWithImage(self.images[indexPath.item])
        return imageCell
    }
}

//MARK: - <UICollectionViewDelegate>

extension PeekPopViewController: UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.imageViewController.setupWithImage(self.images[indexPath.item])
        self.showViewController(self.imageViewController, sender: self)
    }
}

//MARK: - <UICollectionViewDelegateFlowLayout>

extension PeekPopViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0.0, Constants.margin, 25.0, Constants.margin)
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellWidth = (CGRectGetWidth(collectionView.frame)
            - (/*Constants.nbCellPerRow + 1*/ 4.0) * Constants.margin)
            / /*Constants.nbCellPerRow*/ 3.0
            return CGSizeMake(cellWidth, cellWidth)
    }
}
