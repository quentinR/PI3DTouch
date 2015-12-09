//
//  QuickActionsManager.swift
//  PI3DTouch
//
//  Created by Quentin Ribierre on 12/6/15.
//  Copyright © 2015 Prolific Interactive Corp. All rights reserved.
//

import UIKit
import Bond

class QuickActionsManager
{
    //MARK: - ViewControllers Enum
    
    private enum ViewControllerKeys: String {
        case PeekPopViewController
        case EditQuickActionsViewController
        case PressureSensitivityViewController
    }
    
    //MARK: - Properties
    
    var peekAndPopShorCutOn = Observable(false)
    var pressureSensitivityShortCutOn = Observable(false)
    
    //MARK: - Init
    init()
    {
        self.setupShortcutBool()
        self.setupObservers()
    }
    
    //MARK: - Setup Methods
    
    private func setupShortcutBool()
    {
        guard let shortcutItems = UIApplication.sharedApplication().shortcutItems else { return }
        for shortcutItem in shortcutItems {
            if let viewControllerKey = ViewControllerKeys(rawValue: shortcutItem.type) {
                switch viewControllerKey {
                case .PeekPopViewController:
                    self.peekAndPopShorCutOn.next(true)
                case .PressureSensitivityViewController:
                    self.pressureSensitivityShortCutOn.next(true)
                default:
                    break
                }
            }
        }
    }
    
    private func setupObservers()
    {
        self.peekAndPopShorCutOn.observe { (on: Bool) -> Void in
            self.updateShortcut(.PeekPopViewController, on: on)
        }
        self.pressureSensitivityShortCutOn.observe { (on: Bool) -> Void in
            self.updateShortcut(.PressureSensitivityViewController, on: on)
        }
    }
    
    //MARK: - Public Methods
    
    func handleShortcut(shortcut: UIApplicationShortcutItem?) -> Bool
    {
        guard let shortcut = shortcut else { return false }
        // Get the key of the shortcutItem
        let key = self.shortKeyForType(shortcut.type)
        // Check if that key is the key of a knowed viewController
        guard let viewControllerKey = ViewControllerKeys(rawValue: key) else { return false }
        // Try to show This View Controller
        return self.showViewController(viewControllerKey)
    }
    
    //MARK: - Internal Methods - Handle Quick Actions
    
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
    
    //MARK: - Internal Methods - Update Quick Action Sheet
    
    private func updateShortcut(viewControllerKey: ViewControllerKeys, on: Bool)
    {
        if (on && !self.isShortcutItemForKey(viewControllerKey)) {
            self.addShortcut(viewControllerKey)
        } else if (!on) {
            self.removeShortcut(viewControllerKey)
        }
    }
    
    private func addShortcut(viewControllerKey: ViewControllerKeys)
    {
        let shortCutItem = UIMutableApplicationShortcutItem(type: viewControllerKey.rawValue,
            localizedTitle: self.titleForKey(viewControllerKey))
        let icon = UIApplicationShortcutIcon(type: self.iconTypeForKey(viewControllerKey))
        shortCutItem.icon = icon
        UIApplication.sharedApplication().shortcutItems?.append(shortCutItem)
    }
    
    private func removeShortcut(viewControllerKey: ViewControllerKeys)
    {
        guard var shortcutItems = UIApplication.sharedApplication().shortcutItems else { return }
        shortcutItems = shortcutItems.filter({ (shortcutItem: UIApplicationShortcutItem) -> Bool in
            shortcutItem.type != viewControllerKey.rawValue
        })
        UIApplication.sharedApplication().shortcutItems = shortcutItems
    }
    
    private func isShortcutItemForKey(viewControllerKey: ViewControllerKeys) -> Bool
    {
        guard let shortcutItems = UIApplication.sharedApplication().shortcutItems else { return false }
        for shortcutItem in shortcutItems {
            if (shortcutItem.type == viewControllerKey.rawValue) {
                return true
            }
        }
        return false
    }
    
    //MARK: - Internal Methods - Helper Methods
    
    private func titleForKey(viewControllerKey: ViewControllerKeys) -> String
    {
        switch viewControllerKey {
        case .PeekPopViewController:
            return "Peek And Pop"
        case .EditQuickActionsViewController:
            return "Edit Quick Action"
        case .PressureSensitivityViewController:
            return "Pressure Sensitivity"
        }
    }
    
    private func iconTypeForKey(viewControllerKey: ViewControllerKeys) -> UIApplicationShortcutIconType
    {
        switch viewControllerKey {
        case .PeekPopViewController:
            return .CapturePhoto
        case .EditQuickActionsViewController:
            return .Compose
        case .PressureSensitivityViewController:
            return .MarkLocation
        }
    }
    
    private func shortKeyForType(type: String) -> String
    {
        if let key = type.componentsSeparatedByString(".").last {
            return key
        }
        return type
    }
}