//
//  EditQuickActionsViewController.swift
//  PI3DTouch
//
//  Created by Quentin Ribierre on 12/7/15.
//  Copyright © 2015 Prolific Interactive Corp. All rights reserved.
//

import UIKit
import Bond

class EditQuickActionsViewController: UIViewController
{
    
    //MARK: - Properties
    @IBOutlet private weak var peekAndPopSwitch: UISwitch!
    @IBOutlet private weak var pressureSensitivitySwitch: UISwitch!
    
    lazy var quickActionsManager = {
        return QuickActionsManager()
    }()
    
    //MARK: - Viewcontroller Lifecycle
    
    override func viewDidLoad()
    {
        self.setupObservers()
    }
    
    //MARK: - Setup Methods
    
    private func setupObservers()
    {   
        self.quickActionsManager.peekAndPopShorCutOn.bidirectionalBindTo(self.peekAndPopSwitch.bnd_on)
        self.quickActionsManager.pressureSensitivityShortCutOn.bidirectionalBindTo(self.pressureSensitivitySwitch.bnd_on)
    }
}
