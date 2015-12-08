//
//  QuickActionsManager.swift
//  PI3DTouch
//
//  Created by Quentin Ribierre on 12/6/15.
//  Copyright © 2015 Prolific Interactive Corp. All rights reserved.
//

import UIKit

class QuickActionsManager
{
    //MARK: - ViewControllers Enum
    
    enum ViewControllerKeys: String {
        case EditQuickActionsViewController
    }
    
    //MARK: - Public Methods
    
    func handleShortcut(shortcut: UIApplicationShortcutItem?) -> Bool
    {
        // Get the key of the shortcutItem
        guard let key = shortcut?.type.componentsSeparatedByString(".").last else { return false }
        // Check if that key is the key of a knowed viewController
        guard let viewControllerKey = ViewControllerKeys.init(rawValue: key) else { return false }
        // Try to show This View Controller
        return self.showViewController(viewControllerKey)
    }
    
    //MARK: - Internal Methods
    
    private func showViewController(viewControllerKey: ViewControllerKeys) -> Bool
    {
        // Init the storybaord
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Init the root navigationController
        guard let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController else { return false }
        // Set the root navigationController as rootViewController of the application
        UIApplication.sharedApplication().keyWindow?.rootViewController = navigationController
        
        // Init the wanted viewController
        let viewController = storyboard.instantiateViewControllerWithIdentifier(viewControllerKey.rawValue)
        // Push this viewController
        navigationController.pushViewController(viewController, animated: false)
        
        return true
    }
}