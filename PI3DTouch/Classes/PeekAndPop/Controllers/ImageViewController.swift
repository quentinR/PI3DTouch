//
//  ImageViewController.swift
//  PI3DTouch
//
//  Created by Quentin Ribierre on 11/29/15.
//  Copyright © 2015 Prolific Interactive Corp. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController
{
    //MARK: - Properties
    
    @IBOutlet private weak var imageView: UIImageView?
    @IBOutlet private weak var likeButton: UIButton?
    
    weak private var image: Image?
    
    lazy var likeAction: UIPreviewAction = {
        return UIPreviewAction(title: "Like", style: .Default) {
            (action, viewController) -> Void in
            self.like(true)
        }
    }()
    
    lazy var dislikeAction: UIPreviewAction = {
        return UIPreviewAction(title: "Dislike", style: .Destructive) {
            (action, viewController) -> Void in
            self.like(false)
        }
    }()
    
    //MARK: - ViewController LifeCycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let image = self.image {
            self.setupWithImage(image)
        }
    }
    
    //MARK: - Setup Methods
    
    func setupWithImage(image: Image)
    {
        self.image = image
        
        self.imageView?.image = self.image?.image
        self.image?.liked.observe ({ (liked: Bool) -> Void in
            self.likeButton?.selected = liked
        })
    }
    
    //MARK: - IBAction
    
    @IBAction private func likeButtonTapped(sender: AnyObject)
    {
        guard let image = self.image else { return }
        self.like(!image.liked.value)
    }
    
    @IBAction private func backTapped(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: - Preview Actions
    
    override func previewActionItems() -> [UIPreviewActionItem]
    {
        if (self.image?.liked.value == true) {
            return [self.dislikeAction]
        }
        return [self.likeAction]
    }
    
    //MARK: - Private Methods
    
    private func like(like: Bool)
    {
        self.image?.liked.next(like)
    }
}
