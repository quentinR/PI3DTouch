//
//  PeekPopViewController+Extensions.swift
//  PI3DTouch
//
//  Created by Quentin Ribierre on 12/8/15.
//  Copyright © 2015 Prolific Interactive Corp. All rights reserved.
//

import UIKit

// MARK: - PeekPopViewControllerConstants

struct Constants {
    private static let nbCellPerRow        = 3
    private static let margin: CGFloat     = 2.0
}

//MARK: - <UICollectionViewDataSource>

extension PeekPopViewController: UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath)
        -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PeekPopViewControllerConstants.cellReuseIdentifier,
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
