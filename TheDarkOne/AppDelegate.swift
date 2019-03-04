//
//  AppDelegate.swift
//  TheDarkOne
//
//  Created by Dino on 04/03/2019.
//  Copyright © 2019 bornfight. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    private let darkHelper = DarkModeHelpers()
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        DistributedNotificationCenter.default().addObserver(
            self,
            selector: #selector(darkModeChanged(_:)),
            name: NSNotification.Name(rawValue: "AppleInterfaceThemeChangedNotification"),
            object: nil
        )
        
        statusItem.button?.target = darkHelper
        statusItem.button?.action = #selector(darkHelper.toggleDarkMode(_:))
        
        setStatusItemImage()
    }

    @objc private func darkModeChanged(_ notification: Notification) {
        setStatusItemImage()
    }
    
    private func setStatusItemImage() {
        if darkHelper.isDarkMode {
            statusItem.button?.image = darkHelper.darkModeImage
        } else {
            statusItem.button?.image = darkHelper.lightModeImage
        }
    }
}
