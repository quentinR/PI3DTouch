//
//  AppDelegate.swift
//  PI3DTouch
//
//  Created by Quentin Ribierre on 11/28/15.
//  Copyright © 2015 Prolific Interactive Corp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - Properties
    
    var window: UIWindow?
    
    lazy var quickActionManager: QuickActionsManager = {
        return QuickActionsManager()
    }()

    //MARK: - AppDelegate Methods
    
    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        return self.setupQuickActions(launchOptions)
    }
    
    func application(application: UIApplication, performActionForShortcutItem
        shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void)
    {
        completionHandler(self.quickActionManager.handleShortcut(shortcutItem))
    }
    
    //MARK: - Private Methods
    
    private func setupQuickActions(launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        guard let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey]
        as? UIApplicationShortcutItem else { return false }
        return self.quickActionManager.handleShortcut(shortcutItem)
    }
}

