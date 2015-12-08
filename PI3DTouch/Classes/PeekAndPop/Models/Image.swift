//
//  Image.swift
//  PI3DTouch
//
//  Created by Quentin Ribierre on 11/29/15.
//  Copyright © 2015 Prolific Interactive Corp. All rights reserved.
//

import UIKit
import Bond

class Image
{
    //MARK: - Properties
    
    let id: Int
    lazy var image: UIImage? = {
        return UIImage(named: "\(self.id)")
    }()
    var liked = Observable(false)
    
    //MARK: - Init
    
    init(id: Int)
    {
        self.id = id
    }
}
