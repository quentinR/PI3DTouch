//
//  PressureSensitivityViewController.swift
//  PI3DTouch
//
//  Created by Quentin Ribierre on 11/28/15.
//  Copyright © 2015 Prolific Interactive Corp. All rights reserved.
//

import UIKit

class PressureSensitivityViewController: UIViewController
{

    //MARK: - Properties
    
    @IBOutlet weak var forceLabel: UILabel?
    @IBOutlet weak var roundView: UIView?
    @IBOutlet weak var touchMeLabel: UILabel?
    
    //MARK: - ViewController LifeCyle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setupRoundView()
        self.handleNoTouch()
    }
    
    //MARK: - Setup Methods
    
    private func setupRoundView()
    {
        guard let roundViewFrame = self.roundView?.frame else {return}
        self.roundView?.layer.cornerRadius = CGRectGetHeight(roundViewFrame)/2
    }
    
    // MARK: Touch Handling
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.handleTouch(touches)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.handleTouch(touches)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.handleNoTouch()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?)
    {
        self.handleNoTouch()
    }

    //MARK: - Private Methods
    
    private func handleTouch(touches: Set<UITouch>)
    {
        guard let force = touches.first?.force else {return}
        self.displayCurrentForce(force)
        self.manageAnimation(force)
    }
    
    private func displayCurrentForce(force: CGFloat)
    {
        self.forceLabel?.text = String(format: "%.2f", force)
    }
    
    private func handleNoTouch()
    {
        self.displayMaximumForce()
        self.manageAnimation(0.00)
    }
    
    private func displayMaximumForce()
    {
        let touch = UITouch()
        self.forceLabel?.text = "Max = \(String(format: "%.2f", touch.maximumPossibleForce))"
    }
    
    private func manageAnimation(force: CGFloat)
    {
        self.touchMeLabel?.hidden = (force != 0.00)
        self.roundView?.transform = CGAffineTransformMakeScale(force, force)
    }
    
}
