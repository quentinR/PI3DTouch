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
    
    struct PeekPopViewControllerConstants {
        static let cellReuseIdentifier = "ImageCollectionViewCell"
    }
    
    //MARK: - Properties
    
    @IBOutlet private(set) weak var collectionView: UICollectionView?
    
    lazy private(set) var images: Array<Image> = {
        var images = Array<Image>()
        for (var id = 0; id <= 16; id++) {
            images.append(Image(id: id))
        }
        return images
    }()
    
    lazy private(set) var imageViewController: ImageViewController = {
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
        
        self.collectionView?.registerNib(UINib(nibName: PeekPopViewControllerConstants.cellReuseIdentifier, bundle: nil),
            forCellWithReuseIdentifier: PeekPopViewControllerConstants.cellReuseIdentifier)
        
        // if #available(iOS 9, *) { // Uncoment if the target is under iOS 9
            if (traitCollection.forceTouchCapability == .Available) {
                if let collectionView = self.collectionView {
                    registerForPreviewingWithDelegate(self, sourceView: collectionView)
                }
            }
        //}
    }
}

//MARK: - <UIViewControllerPreviewingDelegate>

extension PeekPopViewController: UIViewControllerPreviewingDelegate
{
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController?
    {
        // Indetify the cell touched with the location
        guard let indexPath = collectionView?.indexPathForItemAtPoint(location) else { return nil }
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) else { return nil }
        // Define the sourceRect of the previewingContext with the cell frame
        previewingContext.sourceRect = cell.frame
        
        // Setup the previewing viewController
        self.imageViewController.setupWithImage(self.images[indexPath.item])
        
        // Define the size of the previewwing viewController
        let preferedWidth = CGRectGetWidth(self.view.frame) - 50.0
        self.imageViewController.preferredContentSize = CGSize(width: preferedWidth, height: preferedWidth)
        
        // Return the previewwing viewControll
        return self.imageViewController
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController)
    {
        showViewController(self.imageViewController, sender: self)
    }
}