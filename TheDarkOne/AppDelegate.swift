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

    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        DistributedNotificationCenter.default().addObserver(
            self,
            selector: #selector(darkModeChanged(_:)),
            name: NSNotification.Name(rawValue: "AppleInterfaceThemeChangedNotification"),
            object: nil
        )
        
        statusItem.button?.target = self
        statusItem.button?.action = #selector(toggleDarkMode(_:))
        statusItem.button?.title = "hi"
    }

    @objc private func darkModeChanged(_ notification: Notification) {
        if isDarkMode {
            statusItem.button?.title = "on"
        } else {
            statusItem.button?.title = "off"
        }
    }
    
    var isDarkMode: Bool {
        let script = """
        tell application "System Events"
            tell appearance preferences

                get properties

                return dark mode

            end tell
        end tell
        """
        
        var error: NSDictionary?
        
        return NSAppleScript(source: script)!.executeAndReturnError(&error).booleanValue
    }

    
    @objc func toggleDarkMode(_ sender: Any) {
        let script = "tell application \"System Events\" to tell appearance preferences to set dark mode to not dark mode"
        
        var error: NSDictionary?
        
        if let scriptObject = NSAppleScript(source: script) {
            scriptObject.executeAndReturnError(&error)
        }
    }
}
