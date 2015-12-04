//
//  ImageCollectionViewCell.swift
//  PI3DTouch
//
//  Created by Quentin Ribierre on 11/28/15.
//  Copyright © 2015 Prolific Interactive Corp. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell
{
    
    //MARK: - Properties
    
    @IBOutlet private weak var imageView: UIImageView?
    @IBOutlet private weak var heartButton: UIButton?
    
    weak var image: Image?
    
    //MARK: - Setup Method
    
    func setupWithImage(image: Image)
    {
        self.image = image
        
        self.imageView?.image = self.image?.image
        self.heartButton?.selected = (self.image?.liked == true)
    }
}
