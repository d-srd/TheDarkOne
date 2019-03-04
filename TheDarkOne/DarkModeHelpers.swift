//
//  DarkModeHelpers.swift
//  TheDarkOne
//
//  Created by Dino on 04/03/2019.
//  Copyright © 2019 bornfight. All rights reserved.
//

import Cocoa

class DarkModeHelpers: NSObject {
    let darkModeImage = NSImage(named: "moon-full")
    let lightModeImage = NSImage(named: "moon-outline")
    
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
